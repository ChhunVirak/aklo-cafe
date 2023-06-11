import 'dart:ui';

import 'package:aklo_cafe/util/extensions/fontweight_extension.dart';
import 'package:flutter/material.dart';

class Sizes {
  Sizes._();

  ///Padding Size
  static const double padding = 25.0;
  static const double defaultPadding = 20.0;
  static const double textPadding = 10.0;
  static const double tablePadding = 5.0;

  ///Radius
  static BorderRadius boxBorderRadius = BorderRadius.circular(10);
  static Radius bottomSheetRadius = const Radius.circular(20);
  static BorderRadius bottomSheetBorder = BorderRadius.only(
    topLeft: bottomSheetRadius,
    topRight: bottomSheetRadius,
  );

  ///Text Size
  static const double fL = 17.0;
  static const double fM = 16.0;
  static const double fS = 14.0;

  ///Text Weight
  static const FontWeight wL = FontWeight.w900;
  static const FontWeight wM = FontWeight.w100;
  static const FontWeight wS = FontWeight.w400;
  static const FontWeight bold = FontWeight.bold;

  static final FontVariation weightB = FontWeight.bold.variants;
  static final FontVariation weightL = FontWeight.w600.variants;
  static final FontVariation weightM = FontWeight.w500.variants;
  static final FontVariation weightS = FontWeight.w400.variants;

  //Icon
  static const double listTileIconSize = 40.0;
}
