import 'dart:async';

import 'package:aklo_cafe/constant/firebase_storage_path.dart';
import 'package:aklo_cafe/constant/sizes.dart';
import 'package:aklo_cafe/core/firebase_core/notification_core/firebase_notification_helper.dart';
import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/auth/controller/user_setting_controller.dart';
import 'package:aklo_cafe/module/auth/model/user_model.dart';
import 'package:aklo_cafe/util/alerts/app_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/router/app_pages.dart';
import '../../../util/widgets/app_circular_loading.dart';

class AuthController extends GetxController {
  final _fAuth = FirebaseAuth.instance;

  final emailTxtController = TextEditingController();
  final passwordTxtController = TextEditingController();
  RxBool hidePasword = true.obs;

  String? get userToken => _fAuth.currentUser?.uid;

  @override
  void onInit() {
    _fAuth.authStateChanges().listen(_userChange);
    getUserCredential();
    super.onInit();
  }

  String? get userId => _fAuth.currentUser?.uid;

  RxBool isAdmin = false.obs;

  UserModel? userModel;

  bool checkRolePermission(bool? condition, [void Function()? onAllowed]) {
    if (userModel?.isAdmin == true || (condition ?? false)) {
      onAllowed?.call();
      return true;
    }
    showNoPermission();
    return false;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>>? strUser;

  void _checkRole(User user) async {
    strUser = null;

    isAdmin(false);
    try {
      final id = user.uid;

      strUser = userdb.doc(id).snapshots();

      strUser?.map(
        (doc) {
          final data = doc.data();
          if (data != null) {
            userModel = UserModel.fromMap(data);
            debugPrint('isadmin ${data['role']}');
            isAdmin.value = data['role'] == 'admin';
          }
        },
      );
    } catch (_) {
      debugPrint('Error Aug $_');
      isAdmin(false);
    }
  }

  void _userChange(User? user) {
    debugPrint('USER :  $user');

    if (GetPlatform.isWeb) {
      isAdmin(false);
      return;
    } //end function
    if (user != null) {
      _checkRole(user);
      if (!adminRouter.location.contains(Routes.LOGIN) &&
          !adminRouter.location.contains(Routes.SPLASH)) {
        return;
      }
      NotificationHelper.instance.subscribeAdminTopic();
      //if user already login no change
      adminRouter.go(Routes.DASHBOARD);
    } else {
      isAdmin(false);
      NotificationHelper.instance.unSubscribeAdminTopic();
      adminRouter.go(Routes.LOGIN);
    }
  }

  void signOut() {
    _fAuth.signOut();
    removeUserCredential();
  }

  String? em;
  String? pw;

  void saveUserCredential() async {
    final _pref = await SharedPreferences.getInstance();
    em = emailTxtController.text;
    pw = emailTxtController.text;
    await _pref.setString('em', emailTxtController.text);
    await _pref.setString('pw', emailTxtController.text);
  }

  void removeUserCredential() async {
    final _pref = await SharedPreferences.getInstance();
    em = null;
    pw = null;
    await _pref.remove('em');
    await _pref.remove('pw');
  }

  void getUserCredential() async {
    final _pref = await SharedPreferences.getInstance();
    em = await _pref.getString('em');
    pw = await _pref.getString('pw');
  }

  void onLogin() async {
    if (emailTxtController.text.isNotEmpty &&
        passwordTxtController.text.isNotEmpty) {
      try {
        _showLoading();
        await _fAuth.signInWithEmailAndPassword(
          email: emailTxtController.text,
          password: passwordTxtController.text,
        );

        saveUserCredential();

        // _removeLoading();
      } catch (error) {
        _removeLoading();
        if (error is FirebaseAuthException) {
          showErrorSnackBar(
              title: 'Login Fails', description: '${error.message}');
        }
        debugPrint('Error $error');
      }
    }
  }

  void _showLoading() {
    showDialog(
      context: Get.overlayContext!,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(Sizes.padding),
              child: CustomCircularLoading(),
            ),
          ),
        ),
      ),
    );
  }

  void _removeLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }

  final userdb =
      FirebaseFirestore.instance.collection(FireBaseStoragePath.users);
  final mobileTokenDB =
      FirebaseFirestore.instance.collection(FireBaseStoragePath.mobileToken);

  Future<void> createUser({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (em != null && pw != null) {
        await _fAuth.signInWithEmailAndPassword(email: em!, password: pw!);
      }

      final user = userCredential.user;
      if (user != null) {
        final newUser = UserModel(
          id: user.uid,
          email: email,
          username: username,
          role: 'assistant',
        ).toMap()
          ..removeWhere(
            (key, value) => value == null,
          );
        await userdb.doc(user.uid).set(
              newUser,
            );
        showSuccessSnackBar(
            title: S.current.success,
            description: 'User created successfully.');
        adminRouter.go('/' + Routes.USER);
      }
    } catch (e) {
      if (e is FirebaseException) {
        showErrorSnackBar(title: S.current.fail, description: e.message ?? "");
      }
    }
  }
}
