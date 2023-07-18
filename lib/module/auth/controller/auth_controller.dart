import 'package:aklo_cafe/constant/firebase_storage_path.dart';
import 'package:aklo_cafe/constant/sizes.dart';
import 'package:aklo_cafe/core/firebase_core/notification_core/firebase_notification_helper.dart';
import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/util/alerts/app_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    super.onInit();
  }

  String? get userId => _fAuth.currentUser?.uid;

  RxBool isAdmin = false.obs;

  void checkRole(User user) async {
    isAdmin(false);
    try {
      final id = user.uid;
      await userdb
          .doc(id)
          .get()
          .then(
            (doc) => doc.data(),
          )
          .then(
        (data) {
          if (data != null) {
            debugPrint('isadmin ${data['role']}');
            isAdmin.value = data['role'] == 'admin';
          }
        },
      );
    } catch (_) {
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
      checkRole(user);
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

      final user = userCredential.user;
      if (user != null) {
        await userdb.doc(user.uid).set(
          {
            'id': user.uid,
            'username': username,
            'role': 'assistant',
          },
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
