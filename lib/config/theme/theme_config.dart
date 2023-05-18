import 'package:flutter/material.dart';

import '../../constant/resources.dart';

class AppThemeData {
  static ThemeData get appTheme => ThemeData(
        useMaterial3: true,
        fontFamily: 'Battambang',

        // fontFamily: Get.put(LangsAndFontConfigs()).fontfamily,
        scaffoldBackgroundColor: AppColors.txtLightColor,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.mainColor,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          titleTextStyle: AppStyle.large.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w200,
            // fontVariations: [],
          ),
          iconTheme: const IconThemeData(
            color: AppColors.txtDarkColor,
          ),
          scrolledUnderElevation: 0,
        ),
        // listTileTheme: ListTileThemeData()
      );
}
