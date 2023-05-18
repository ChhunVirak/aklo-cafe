import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomModalBottomSheet(Widget child) {
  showModalBottomSheet(
    context: Get.context!,
    builder: (_) => child,
  );
}
