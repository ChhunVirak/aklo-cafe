import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showCustomModalBottomSheet(Widget child) async {
  await showModalBottomSheet(
    context: Get.overlayContext!,
    builder: (_) => Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(Get.overlayContext!).pop();
          },
          child: Container(
            height: Get.height,
            width: Get.width,
            color: Colors.transparent,
          ),
        ),
        Container(
          color: Colors.white,
          width: double.infinity,
          height: Get.height * 0.5,
          child: child,
        ),
      ],
    ),
  );
}
