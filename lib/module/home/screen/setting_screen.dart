import 'package:aklo_cafe/config/languages/lang_font_controller.dart';
import 'package:aklo_cafe/module/auth/controller/auth_controller.dart';
import 'package:aklo_cafe/module/home/screen/edit_slides.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

import '../../../generated/l10n.dart';
import '../../../util/alerts/app_dialog.dart';
import '../../../util/widgets/custom_listtile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    final languageController = Get.put(LangsAndFontConfigs());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomListtile(
          title: S.current.languages,
          subtitle: S.current.languagesDes,
          leading: TileIcon.iconData(PhosphorIcons.translate),
          onTap: () {
            languageController.chooseLangauge();
          },
        ),
        // const Spacer(),
        CustomListtile(
          title: S.current.edit_slide,
          // subtitle: 'Edit Slider',
          leading: TileIcon.iconData(PhosphorIcons.cards),
          onTap: () {
            Get.to(() => EditSlide());
          },
        ),
        CustomListtile(
          title: S.current.signout,
          // subtitle: '${S.current.signout} of virak',
          leading: TileIcon.iconData(PhosphorIcons.sign_out),
          onTap: () {
            showCustomDialog(
              title: S.current.confirm,
              description: S.current.logout_message,
              actions: [
                TextButton(
                  onPressed: () {
                    authController.signOut();
                  },
                  child: Text(S.current.yes),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(S.current.cancel),
                ),
              ],
            );
          },
        ),
        30.sh,
      ],
    );
  }
}
