import 'package:flutter/material.dart';

import '../../constant/resources.dart';

class ThemeConfig {
  ThemeConfig._();
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        fontFamily: AppStyle.fontFamily,
        // splashFactory: NoSplash.splashFactory,
        // fontFamily: Get.put(LangsAndFontConfigs()).fontfamily,
        scaffoldBackgroundColor: AppColors.txtLightColor,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.mainColor,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            // if (states.contains(MaterialState.selected)) {
            //   return Colors.orange.withOpacity(.48);
            // }
            return Colors.white;
          }),
          trackColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (!states.contains(MaterialState.selected)) {
              return Colors.red;
            }
            return AppColors.mainColor;
          }),
          // inactiveTrackColor: Colors.red,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          titleTextStyle: AppStyle.large.copyWith(
            fontSize: 20.0,
            fontWeight: FontWeight.w200,
          ),
          iconTheme: const IconThemeData(
            color: AppColors.txtDarkColor,
          ),
          scrolledUnderElevation: 0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedLabelStyle:
              AppStyle.small.copyWith(fontVariations: [AppStyle.weightM]),
          unselectedLabelStyle:
              AppStyle.small.copyWith(fontVariations: [AppStyle.weightM]),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          surfaceTintColor: Colors.transparent,
          modalBackgroundColor: AppColors.backgroundColor,
          backgroundColor: AppColors.backgroundColor,
        ),
        listTileTheme: ListTileThemeData(
          titleTextStyle: AppStyle.large,
          leadingAndTrailingTextStyle: AppStyle.large,
        ),
        chipTheme: const ChipThemeData(
          shape: StadiumBorder(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.lightColor,
            textStyle: AppStyle.medium,
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            visualDensity: const VisualDensity(
              vertical: -2,
              horizontal: -2,
            ),
            padding: EdgeInsets.zero,
          ),
        ),
      );
}
