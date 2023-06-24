import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/about_us/model/profile_detail_model.dart';
import 'package:aklo_cafe/util/alerts/app_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final _db = FirebaseFirestore.instance.collection('about-us');

  final name = TextEditingController();
  final email = TextEditingController();
  final department = TextEditingController();
  final bio = TextEditingController();

  Future<void> addMember() async {
    final data = ProfileModel(
            name: name.text,
            email: email.text,
            department: department.text,
            bio: bio.text)
        .toMap();
    try {
      final id = await _db.add(data).then((value) => value.id);
      await _db.doc(id).update(
        {
          'id': id,
        },
      );
    } catch (e) {
      if (e is FirebaseException)
        showErrorSnackBar(title: S.current.fail, description: e.message ?? '');
    }
  }
}
