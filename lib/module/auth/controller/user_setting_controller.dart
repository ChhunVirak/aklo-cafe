import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../constant/firebase_storage_path.dart';
import '../../../generated/l10n.dart';
import '../../../util/alerts/app_snackbar.dart';
import '../model/user_model.dart';

class UserSettingController extends GetxController {
  final userdb =
      FirebaseFirestore.instance.collection(FireBaseStoragePath.users);
  final userModel = UserModel().obs;
  final loading = false.obs;
  Future<void> getUserSetting(String userId) async {
    loading(true);
    final user = await userdb.doc(userId).get().then((doc) => doc.data());
    debugPrint('DATAAAs $userId');
    if (user != null) {
      debugPrint('DATAAAs');
      userModel.value = UserModel.fromMap(user);
    }
    loading(false);
  }

  Future<void> updatePermission(String userId, Map<String, bool> data) async {
    await userdb.doc(userId).update(data);
  }
}

void showNoPermission() {
  showErrorSnackBar(
      title: S.current.alert, description: S.current.noPermission);
}
