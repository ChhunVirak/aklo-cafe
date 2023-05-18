import 'package:aklo_cafe/config/languages/lang_font_controller.dart';
import 'package:aklo_cafe/constant/textstyle/khmer_textstlye.dart';
import 'package:aklo_cafe/module/auth/controller/auth_controller.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/resources.dart';
import '../../../generated/l10n.dart';
import '../../../util/alerts/app_dialog.dart';
import '../../../util/alerts/app_modal_bottomsheet.dart';
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
          leading: TileIcon.iconData(Icons.language),
          onTap: () {
            showCustomModalBottomSheet(
              Material(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.only(
                  topLeft: Sizes.bottomSheetRadius,
                  topRight: Sizes.bottomSheetRadius,
                ),
                color: AppColors.txtLightColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        left: 15.0,
                      ),
                      child: Text(
                        S.current.languagesDes,
                        style: AppStyle.large,
                      ),
                    ),
                    CustomListtile(
                      title: 'ភាសាខ្មែរ',
                      subtitle: 'នេះជាឧទាហរណ៍នៃភាសាខ្មែរ',
                      textStyle: KhmerFontStyle().styleL(),
                      trailing: !languageController.isEnglish
                          ? const Icon(Icons.done_rounded)
                          : null,
                      onTap: () {
                        Navigator.pop(context);
                        languageController.changeLanguage(Langs.khmer);
                      },
                    ),
                    SafeArea(
                      top: false,
                      minimum: const EdgeInsets.only(bottom: 20),
                      child: CustomListtile(
                        title: 'English',
                        subtitle: 'This is an example of English language',
                        trailing: languageController.isEnglish
                            ? const Icon(Icons.done_rounded)
                            : null,
                        onTap: () {
                          Navigator.pop(context);
                          languageController.changeLanguage(Langs.english);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        // const Spacer(),
        CustomListtile(
          title: S.current.signout,
          subtitle: '${S.current.signout} of virak',
          leading: TileIcon.iconData(Icons.no_accounts_rounded),
          onTap: () {
            showCustomDialog(
              title: 'Alert',
              description: 'Are you sure want to sign out?',
              actions: [
                TextButton(
                  onPressed: () {
                    authController.signOut();
                  },
                  child: const Text('Ok'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
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
