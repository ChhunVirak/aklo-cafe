import 'dart:ui';

import 'package:aklo_cafe/constant/resources.dart';

import 'package:flutter/material.dart';

import 'app_base_textstyle.dart';

class EnglishFontStyle extends BaseTextStyle {
  @override
  final Locale locale = const Locale('en', 'EN');

  @override
  final String fontFamily = 'KantumruyPro';

  @override
  final double sizeL = Sizes.fL;

  @override
  final double sizeM = Sizes.fM;

  @override
  final double sizeR = Sizes.fM;

  @override
  final double sizeS = Sizes.fS;

  @override
  final FontVariation weightB = Sizes.weightB;

  @override
  final FontVariation weightL = Sizes.weightL;

  @override
  final FontVariation weightM = Sizes.weightM;

  @override
  final FontVariation weightS = Sizes.weightS;

  @override
  TextStyle styleL() => TextStyle(
        fontFamily: fontFamily,
        color: AppColors.txtDarkColor,
        fontSize: Sizes.fL,
        fontVariations: [weightL],
      );

  @override
  TextStyle styleM() => TextStyle(
        fontFamily: fontFamily,
        color: AppColors.txtDarkColor,
        fontSize: Sizes.fM,
        fontVariations: [weightM],
      );

  @override
  TextStyle styleR() => TextStyle(
        fontFamily: fontFamily,
        color: AppColors.txtDarkColor,
        fontSize: Sizes.fM,
        fontVariations: [weightM],
      );

  @override
  TextStyle styleS() => TextStyle(
        fontFamily: fontFamily,
        color: AppColors.txtDarkColor,
        fontSize: Sizes.fS,
        fontVariations: [weightS],
      );
}
