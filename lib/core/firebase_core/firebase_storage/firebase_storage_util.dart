import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart' show debugPrint;
import 'dart:io' show File;

class FirebaseStorageUtils {
  final ref = FirebaseStorage.instance.ref();
  Future<bool> deleteFile({required String? url}) async {
    if (url == null || url.isEmpty) return false;
    try {
      await FirebaseStorage.instance.refFromURL(url).delete();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<String?> uploadFile(
      {required String name,
      required String directory,
      required File? file}) async {
    String? downloadUrl;

    if (file != null) {
      try {
        downloadUrl = await ref
            .child('${directory}/$name')
            .putFile(file)
            .then((ref) async => await ref.ref.getDownloadURL());
      } catch (message) {
        debugPrint('Upload Fail : $message');
      }
    } else {
      debugPrint('File not found');
    }
    return downloadUrl;
  }
}
