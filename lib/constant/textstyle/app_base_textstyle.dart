import 'dart:ui';

import 'package:flutter/material.dart';

///R = regular
///S = small
///M = medium
///L = large
abstract class BaseTextStyle {
  abstract final Locale locale;
  abstract final String fontFamily;

  abstract final double sizeR;
  abstract final double sizeS;
  abstract final double sizeM;
  abstract final double sizeL;

  abstract final FontVariation weightB;
  abstract final FontVariation weightS;
  abstract final FontVariation weightM;
  abstract final FontVariation weightL;

  TextStyle styleR();
  TextStyle styleS();
  TextStyle styleM();
  TextStyle styleL();
}
