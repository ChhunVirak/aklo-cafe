import 'package:aklo_cafe/binding/app_binding.dart';
import 'package:aklo_cafe/firebase_options.dart';
import 'package:aklo_cafe/config/app_setting.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/router/app_router.dart';
import 'constant/resources.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppSetting.instance.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aklo Cafe',
      initialRoute: '/',
      getPages: GetRoutes().routes,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Nunito',
        // textTheme: const TextTheme(),
        scaffoldBackgroundColor: AppColors.txtLightColor,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
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
      ),
      initialBinding: AppBinding(),
      // home: const DashBoard(),
    );
  }
}
