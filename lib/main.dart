import 'package:aklo_cafe/firebase_options.dart';
import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/auth/controller/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'binding/app_binding.dart';
import 'config/languages/lang_font_controller.dart';
import 'config/router/app_pages.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'constant/resources.dart';

import 'package:flutter_web_plugins/url_strategy.dart';

import 'core/firebase_core/notification_core/firebase_notification_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight,
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationHelper.instance.init();
  // await AppSetting.instance.init();
  runApp(
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final fontController = Get.put(LangsAndFontConfigs());

    return GetBuilder<LangsAndFontConfigs>(
      init: fontController,
      initState: (state) async {
        await NotificationHelper.instance.android.then((v) {
          debugPrint('Operating Systemm Version :${v.version.sdkInt}');
        });
        if (!kIsWeb) {
          final tk = await NotificationHelper.instance.getDeviceToken();
          debugPrint('Token=>  : $tk');
          Get.put(AuthController()).storeDeviceToken(tk);
        }
      },
      builder: (_) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aklo Cafe',
        initialBinding: AppBinding(),
        locale: const Locale('en'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        initialRoute: AppPages.getInitialRoute,
        getPages:
            GetPlatform.isWeb ? AppPages.routesClient : AppPages.routesAdmin,
        unknownRoute: AppPages.routesClient.first,
        // onUnknownRoute: (settings) => GetPageRoute(),
        theme: ThemeData(
            useMaterial3: true,
            fontFamily: AppStyle.fontFamily,

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
            chipTheme: const ChipThemeData(
              shape: StadiumBorder(),
            )
            // listTileTheme: ListTileThemeData()
            ),
      ),
    );
  }
}
