import 'package:aklo_cafe/constant/firebase_storage_path.dart';
import 'package:aklo_cafe/constant/sizes.dart';
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

  ///Store Device token to firebase
  Future<void> storeDeviceToken(String? token) async {
    final data = await mobileTokenDB.get();
    if (data.docs.isEmpty) {
      await mobileTokenDB.add({'device-token': token});
      return; //end function after token not found
    }

    final id = data.docs.first.id;
    await mobileTokenDB.doc(id).update({'device-token': token});
  }

  ///Get current Admin Device token from firebase
  Future<String?> getDeviceToken() async {
    final data = await mobileTokenDB.get();
    if (data.docs.isNotEmpty) {
      return data.docs.first['device-token'];
    }
    return null;
  }

  @override
  void onInit() {
    _fAuth.userChanges().listen(_userChange);
    super.onInit();
  }

  void _userChange(User? user) {
    debugPrint('USER :  $user');
    if (GetPlatform.isWeb) return; //end function
    if (user != null) {
      // if (Get.currentRoute != Routes.LOGIN ||
      //     Get.currentRoute != Routes.SPLASH) {
      //   return;
      // }
      //if user already login no change
      Get.offAllNamed(Routes.DASHBOARD);
    } else {
      Get.offAllNamed(Routes.LOGIN);
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
}
