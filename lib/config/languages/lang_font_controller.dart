import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/resources.dart';
import '../../constant/textstyle/english_textstlye.dart';
import '../../constant/textstyle/khmer_textstlye.dart';
import '../../generated/l10n.dart';
import '../../util/alerts/app_modal_bottomsheet.dart';
import '../../util/widgets/custom_listtile.dart';

enum Langs {
  english,
  khmer;
}

extension LangsEx on Langs {
  Locale get locale {
    switch (this) {
      case Langs.khmer:
        return KhmerFontStyle().locale;
      case Langs.english:
        return EnglishFontStyle().locale;
    }
  }

  String get countryCode {
    switch (this) {
      case Langs.khmer:
        return KhmerFontStyle().locale.countryCode!;
      case Langs.english:
        return EnglishFontStyle().locale.countryCode!;
    }
  }
}

class LangsAndFontConfigs extends GetxController {
  ///
  @override
  void onInit() async {
    _pref = await SharedPreferences.getInstance();
    _checkCurrentLanguage();
    super.onInit();
  }

  late SharedPreferences _pref;

  String get currentFontFamily => _currentLocale == EnglishFontStyle().locale
      ? EnglishFontStyle().fontFamily
      : KhmerFontStyle().fontFamily;

  Locale _currentLocale = EnglishFontStyle().locale;

  Locale get currentLocale => _currentLocale;

  bool get isEnglish => _currentLocale == EnglishFontStyle().locale;

  void _checkCurrentLanguage() {
    final currentLanguage = _pref.getString('AppLocale');
    if (currentLanguage == Langs.khmer.countryCode) {
      debugPrint('Workk');
      _currentLocale = Langs.khmer.locale;
      changeLanguage(Langs.khmer);
    } else {
      _currentLocale = Langs.english.locale;
      changeLanguage(Langs.english);
    }

    update();
  }

  void changeLanguage(Langs lan) async {
    _currentLocale = lan.locale;
    Get.updateLocale(lan.locale);
    update();
    debugPrint('Locale Code ${lan.countryCode}');
    await _pref.setString('AppLocale', lan.countryCode);
  }

  void chooseLangauge() {
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
              trailing: !isEnglish ? const Icon(Icons.done_rounded) : null,
              onTap: () {
                changeLanguage(Langs.khmer);
                if (Get.overlayContext == null) return;
                Navigator.pop(Get.overlayContext!);
              },
            ),
            SafeArea(
              top: false,
              minimum: const EdgeInsets.only(bottom: 20),
              child: CustomListtile(
                title: 'English',
                subtitle: 'This is an example of English language',
                trailing: isEnglish ? const Icon(Icons.done_rounded) : null,
                onTap: () {
                  changeLanguage(Langs.english);
                  if (Get.overlayContext == null) return;
                  Navigator.pop(Get.overlayContext!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
