import 'package:aklo_cafe/config/theme/theme_config.dart';
import 'package:aklo_cafe/firebase_options.dart';
import 'package:aklo_cafe/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'binding/app_binding.dart';
import 'config/languages/lang_font_controller.dart';
import 'config/router/app_pages.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_web_plugins/url_strategy.dart';

import 'core/firebase_core/notification_core/firebase_notification_helper.dart';
import 'module/home/controller/dashboard_controller.dart';

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
  runApp(
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final fontController = Get.put(LangsAndFontConfigs());
    AppBinding().dependencies();

    return GetBuilder<LangsAndFontConfigs>(
      init: fontController,
      initState: (state) async {
        Get.put(DashBoardController()).getMenuIcon();
      },
      builder: (_) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Aklo Cafe',
          locale: fontController.currentLocale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          routerConfig: GetPlatform.isWeb ? clientRouter : adminRouter,
          theme: ThemeConfig.lightTheme,
        );
      },
    );
  }
}
