import 'package:aklo_cafe/config/languages/lang_font_controller.dart';
import 'package:aklo_cafe/constant/sizes.dart';
import 'package:aklo_cafe/constant/strings.dart';
import 'package:aklo_cafe/constant/textstyle.dart';
import 'package:aklo_cafe/module/auth/controller/auth_controller.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:aklo_cafe/util/widgets/custom_button.dart';
import 'package:aklo_cafe/util/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aklo_cafe/util/extensions/fontweight_extension.dart';

import '../../../generated/l10n.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    final langController = Get.put(LangsAndFontConfigs());
    final formKey = GlobalKey<FormState>();
    debugPrint('Success ${S.current.login}');
    return Scaffold(
      body: GetBuilder(
        init: controller,
        initState: (state) {
          controller.hidePasword(false);
        },
        builder: (_) => SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                  left: Sizes.defaultPadding,
                  right: Sizes.defaultPadding,
                  bottom: 100),
              child: Column(
                children: [
                  const Icon(
                    Icons.supervised_user_circle,
                    size: 100,
                    color: null,
                  ),
                  Center(
                    child: Text(
                      Strings.cafeName,
                      style: AppStyle.large
                          .copyWith(fontWeight: Sizes.bold, fontSize: 30),
                    ),
                  ),
                  Center(
                    child: Text(
                      Strings.cafeDescription,
                      style: AppStyle.small.copyWith(
                        fontVariations: [FontWeight.w200.variants],
                      ),
                    ),
                  ),
                  30.sh,
                  FocusScope(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            label: S.current.email,
                            controller: controller.emailTxtController,
                            textInputAction: TextInputAction.next,
                            validator: (v) =>
                                v == '' ? Strings.emailValidateMessage : null,
                          ),
                          Obx(
                            () => CustomTextField(
                              label: S.current.password,
                              controller: controller.passwordTxtController,
                              textInputAction: TextInputAction.done,
                              maxLines: 1,
                              onFieldSubmitted: (_) {
                                final validated =
                                    formKey.currentState?.validate();
                                if (validated != null && validated == true) {
                                  controller.onLogin();
                                }
                              },
                              obscureText: controller.hidePasword.value,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.hidePasword.value =
                                      !controller.hidePasword.value;
                                },
                                icon: Icon(controller.hidePasword.value
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded),
                              ),
                              validator: (v) => v == ''
                                  ? Strings.passwordValidateMessage
                                  : null,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    onPressed: () {
                      final validated = formKey.currentState?.validate();
                      if (validated != null && validated == true) {
                        controller.onLogin();
                      }
                    },
                    name: S.current.login,
                  ),
                  20.sh,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.current.languagesDes,
                      style: AppStyle.medium,
                    ),
                  ),
                  10.sh,
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          backgroundColor:
                              langController.isEnglish ? null : Colors.grey,
                          onPressed: () {
                            langController.changeLanguage(Langs.english);
                          },
                          name: 'English',
                        ),
                      ),
                      20.sw,
                      Expanded(
                        child: CustomButton(
                          backgroundColor:
                              !langController.isEnglish ? null : Colors.grey,
                          onPressed: () {
                            langController.changeLanguage(Langs.khmer);
                          },
                          name: 'ភាសាខ្មែរ',
                        ),
                      ),
                    ],
                  ),
                  20.sh,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
