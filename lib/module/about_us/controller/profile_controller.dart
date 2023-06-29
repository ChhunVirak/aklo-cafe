import 'package:aklo_cafe/config/router/app_pages.dart';
import 'package:aklo_cafe/constant/firebase_storage_path.dart';
import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/about_us/model/profile_detail_model.dart';
import 'package:aklo_cafe/module/inventory/controller/controller.dart';
import 'package:aklo_cafe/util/alerts/app_dialog.dart';
import 'package:aklo_cafe/util/alerts/app_snackbar.dart';
import 'package:aklo_cafe/util/extensions/object_validation_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' show TextEditingController;
import 'package:get/get.dart';

import 'dart:io' show File;

class ProfileController extends GetxController {
  final _db = FirebaseFirestore.instance.collection('about-us');

  Stream<List<ProfileModel>> get streamProfiles =>
      _db.snapshots().map((query) => query.docs).map(
            (list) => list
                .map(
                  (e) => ProfileModel.fromMap(
                    e.data(),
                  ),
                )
                .toList(),
          );
  Stream<ProfileModel?> streamProfile(String id) => _db
      .doc(id)
      .snapshots()
      .map((document) => document.data())
      .map((data) => data != null ? ProfileModel.fromMap(data) : null);

  final name = TextEditingController();
  final email = TextEditingController();
  final department = TextEditingController();
  final bio = TextEditingController();

  String? selectedProfile;
  String? defaultImageNetwork;

  Future<void> addMember() async {
    showLoadingDialog();
    final data = ProfileModel(
      name: name.text,
      email: email.text,
      department: department.text,
      bio: bio.text,
    ).toMap();

    data.removeWhere((key, value) => value == null);
    String? getDownloadURL;
    try {
      final id = await _db.add(data).then((value) => value.id);
      if (selectedProfile.isValid) {
        getDownloadURL = await Get.put(InventoryController()).uploadFile(
            id: id,
            type: FireBaseStoragePath.member,
            file: File(selectedProfile!));
      }
      await _db.doc(id).update(
        {
          'id': id,
          'image': getDownloadURL,
        },
      );
      removeDialog();
      adminRouter.go(Routes.ABOUT_US_FULL);
      showSuccessSnackBar(
          title: S.current.success, description: S.current.add_success);
    } catch (e) {
      removeDialog();
      if (e is FirebaseException)
        showErrorSnackBar(title: S.current.fail, description: e.message ?? '');
    }
  }

  Future<void> updateMember(String id) async {
    final data = ProfileModel(
            name: name.text,
            email: email.text,
            department: department.text,
            bio: bio.text)
        .toMap();
    data.removeWhere((key, value) => value == null);
    try {
      await _db.doc(id).update(data);
    } catch (e) {
      if (e is FirebaseException)
        showErrorSnackBar(title: S.current.fail, description: e.message ?? '');
    }
  }
}
