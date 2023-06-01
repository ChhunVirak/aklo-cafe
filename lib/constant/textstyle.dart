import 'dart:ui';

import 'package:aklo_cafe/config/languages/lang_font_controller.dart';
import 'package:aklo_cafe/constant/textstyle/khmer_textstlye.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'textstyle/english_textstlye.dart';

class AppStyle {
  AppStyle._();
  static get _controller => Get.put(LangsAndFontConfigs());

  static FontVariation get weightL => _controller.isEnglish
      ? EnglishFontStyle().weightL
      : KhmerFontStyle().weightL;

  static FontVariation get weightM => _controller.isEnglish
      ? EnglishFontStyle().weightM
      : KhmerFontStyle().weightM;

  static FontVariation get weightS => _controller.isEnglish
      ? EnglishFontStyle().weightS
      : KhmerFontStyle().weightS;

  static TextStyle get large => _controller.isEnglish
      ? EnglishFontStyle().styleL()
      : KhmerFontStyle().styleL();

  static TextStyle get medium => _controller.isEnglish
      ? EnglishFontStyle().styleM()
      : KhmerFontStyle().styleM();

  static TextStyle get small => _controller.isEnglish
      ? EnglishFontStyle().styleS()
      : KhmerFontStyle().styleS();

  static const boxShadow = BoxShadow(
    color: Colors.grey,
    offset: Offset(1, 1),
    spreadRadius: 1,
    blurRadius: 8,
  );
}
