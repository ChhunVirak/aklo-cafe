import 'package:aklo_cafe/binding/app_binding.dart';
import 'package:aklo_cafe/module/config/app_setting.dart';
import 'package:aklo_cafe/module/home/screen/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constant/resources.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppSetting.instance.init();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aklo Cafe',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.txtLightColor,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          titleTextStyle: AppStyle.large.copyWith(fontSize: 20),
          iconTheme: const IconThemeData(
            color: AppColors.txtDarkColor,
          ),
        ),
      ),
      initialBinding: AppBinding(),
      home: DashBoard(),
    );
  }
}
