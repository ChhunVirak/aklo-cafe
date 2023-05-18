import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/textstyle/english_textstlye.dart';
import '../../constant/textstyle/khmer_textstlye.dart';

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

  bool get isEnglish => _currentLocale == EnglishFontStyle().locale;

  void _checkCurrentLanguage() {
    final currentLanguage = _pref.getString('AppLocale');
    if (_currentLocale.countryCode != currentLanguage) {
      if (currentLanguage == Langs.english.countryCode) {
        changeLanguage(Langs.english);
      } else {
        changeLanguage(Langs.khmer);
      }
    }
    update();
  }

  void changeLanguage(Langs lan) async {
    _currentLocale = lan.locale;
    debugPrint('Locale Code ${lan.countryCode}');
    await _pref.setString('AppLocale', lan.countryCode);
    Get.updateLocale(lan.locale);

    update();
  }
}
