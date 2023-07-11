import 'dart:io' show File;

import 'package:aklo_cafe/core/firebase_core/firebase_storage/firebase_storage_util.dart';
import 'package:aklo_cafe/module/home/model/slide_model.dart';
import 'package:aklo_cafe/util/alerts/app_dialog.dart';
import 'package:aklo_cafe/util/extensions/object_validation_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditSlideController extends GetxController with FirebaseStorageUtils {
  final _db = FirebaseFirestore.instance.collection('sliders');

  Stream<List<SlideModel>>? get sliderSnapShot => _db
      .orderBy(
        'uploadedDate',
      )
      .snapshots()
      .map((query) => query.docs)
      .map(
          (docs) => docs.map((doc) => SlideModel.fromMap(doc.data())).toList());

  final currentIndex = 0.obs;

  Future<void> submitNewSlide({required String? url, File? file}) async {
    showLoadingDialog();
    try {
      final data = SlideModel(
        image: url,
        uploadedDate: Timestamp.fromDate(
          DateTime.now(),
        ),
      ).toMap()
        ..removeWhere(
          (_, value) => value == null,
        );
      final doc = await _db.add(data);
      String? downloadUrl = url;

      if (file != null) {
        try {
          downloadUrl =
              await uploadFile(name: doc.id, directory: 'slides', file: file);
        } catch (_) {}
      }

      final updateData = {
        'id': doc.id,
        'image': downloadUrl,
      }..removeWhere((_, value) => !value.isValid);

      await doc.update(updateData);
    } catch (e) {
      debugPrint("Upload Error $e");
    } finally {
      removeDialog();
    }
  }

  Future<void> updateSlide(
      {required String id, String? url, File? file, String? oldUrl}) async {
    try {
      showLoadingDialog();
      final downloadUrl =
          await uploadFile(name: id, directory: 'slides', file: file);
      await _db.doc(id).update({'image': url ?? downloadUrl});
      await deleteFile(url: url);
    } catch (_) {
    } finally {
      removeDialog();
    }
  }

  Future<void> deleteImage(SlideModel slideModel) async {
    showLoadingDialog();
    try {
      await _db.doc(slideModel.id).delete();
      await deleteFile(url: slideModel.image);
    } catch (_) {
    } finally {
      removeDialog();
    }
  }
}
