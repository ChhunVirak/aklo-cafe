import 'package:aklo_cafe/constant/resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showErrorSnackBar({required String title, required String description}) {
  Get.snackbar(
    title, description,
    duration: const Duration(
      seconds: 2,
    ),
    // snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    backgroundColor: Colors.red,
    borderRadius: 10,
    margin: const EdgeInsets.all(Sizes.defaultPadding),
  );
}

void showSuccessSnackBar({required String title, required String description}) {
  Get.snackbar(
    title,
    description,
    duration: const Duration(
      seconds: 2,
    ),
    colorText: Colors.white,
    backgroundColor: Colors.green,
    borderRadius: 10,
    margin: const EdgeInsets.all(Sizes.defaultPadding),
  );
}
