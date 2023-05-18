import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/resources.dart';
import '../widgets/app_circular_loading.dart';

void showCustomDialog({
  required String title,
  required String description,
  List<Widget>? actions,
}) {
  Get.dialog(
    AlertDialog(
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: Sizes.boxBorderRadius),
      title: Text(title),
      content: Text(description),
      titlePadding: const EdgeInsets.only(
        top: Sizes.textPadding,
        left: Sizes.defaultPadding,
      ),
      contentPadding: const EdgeInsets.only(
          left: Sizes.defaultPadding, right: Sizes.defaultPadding),
      actionsPadding: const EdgeInsets.only(
        right: Sizes.textPadding,
      ),
      actions: actions,
    ),
  );
}

void showLoadingDialog() {
  Get.dialog(
    WillPopScope(
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
