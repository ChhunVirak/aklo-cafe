import 'package:aklo_cafe/constant/resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showCustomModalBottomSheet(Widget child) async {
  await Get.bottomSheet(
    Stack(
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
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: Sizes.bottomSheetBorder,
          ),
          width: double.infinity,
          constraints: BoxConstraints(maxHeight: Get.height * 0.5),
          child: child,
        ),
      ],
    ),
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
  );
}
