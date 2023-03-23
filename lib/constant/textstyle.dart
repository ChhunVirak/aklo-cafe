import 'package:aklo_cafe/constant/resources.dart';

import 'package:flutter/material.dart';

class AppStyle {
  AppStyle._();

  static const large = TextStyle(
    color: AppColors.txtDarkColor,
    fontSize: Sizes.fL,
    fontWeight: Sizes.wL,
  );

  static const medium = TextStyle(
    color: AppColors.txtDarkColor,
    fontSize: Sizes.fM,
    fontWeight: Sizes.wM,
  );

  static const small = TextStyle(
    color: AppColors.txtDarkColor,
    fontSize: Sizes.fS,
    fontWeight: Sizes.wS,
  );

  static const boxShadow = BoxShadow(
    color: Color.fromARGB(40, 52, 42, 33),
    spreadRadius: 0.1,
    blurRadius: 8,
  );
}
