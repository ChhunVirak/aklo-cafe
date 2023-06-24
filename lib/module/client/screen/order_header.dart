import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

import '../../../config/languages/lang_font_controller.dart';
import '../../../constant/resources.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final languageController = Get.put(LangsAndFontConfigs());
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: Sizes.boxBorderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 0.1,
            blurRadius: 6,
          ),
        ],
      ),
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image.asset(
            'assets/logo/aklo-cafe-logo.png',
            width: 50,
          ),
          10.sw,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Aklo Cafe',
                style: AppStyle.medium,
              ),
              Text("E-Menu"),
            ],
          ),
          Spacer(),
          ElevatedButton.icon(
            onPressed: () {
              languageController.chooseLangauge();
            },
            icon: Icon(PhosphorIcons.translate),
            label: Text(
              languageController.isEnglish ? "English" : 'ខ្មែរ',
            ),
          )
        ],
      ),
    );
  }
}
