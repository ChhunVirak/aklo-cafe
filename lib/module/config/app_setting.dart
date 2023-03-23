import 'package:flutter/services.dart';

class AppSetting {
  AppSetting._();
  static final instance = AppSetting._();

  void _setDeviceOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void init() {
    _setDeviceOrientation();
  }
}
