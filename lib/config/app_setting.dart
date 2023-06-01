import 'package:flutter/services.dart';

class AppSetting {
  AppSetting._();
  static final instance = AppSetting._();

  Future<void> _setDeviceOrientation() async {
    await SystemChrome.setPreferredOrientations([
      // DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future<void> init() async {
    await _setDeviceOrientation();
  }
}
