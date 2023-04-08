import 'dart:ui';

import 'package:aklo_cafe/constant/resources.dart';

import 'package:flutter/material.dart';

class AppStyle {
  AppStyle._();

  static const large = TextStyle(
    fontFamily: 'Nunito',
    color: AppColors.txtDarkColor,
    fontSize: Sizes.fL,
    fontWeight: Sizes.wM,
    fontVariations: [FontVariation('wght', 700)],
  );

  static const medium = TextStyle(
    fontFamily: 'Nunito',
    color: AppColors.txtDarkColor,
    fontSize: Sizes.fM,
    fontWeight: Sizes.wL,
    fontVariations: [FontVariation('wght', 500)],
  );

  static const small = TextStyle(
    fontFamily: 'Nunito',
    color: AppColors.txtDarkColor,
    fontSize: Sizes.fS,
    fontWeight: Sizes.wL,
    fontVariations: [FontVariation('wght', 400)],
  );

  static const boxShadow = BoxShadow(
    color: Color.fromARGB(40, 52, 42, 33),
    spreadRadius: 0.1,
    blurRadius: 8,
  );
}
