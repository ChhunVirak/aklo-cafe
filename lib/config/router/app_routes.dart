// ignore_for_file: non_constant_identifier_names, constant_identifier_names, unused_field
part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASHSCREEN;

  static const LOGIN = _Paths.LOGIN;
  static const DASHBOARD = _Paths.DASHBOARD;
  static const INVENTORY = _Paths.DASHBOARD + _Paths.INVENTORY;

  ///Client Order
  static const CLIENT_ORDER = _Paths.CLIENT_ORDER;
}

abstract class _Paths {
  _Paths._();
  static const SPLASHSCREEN = '/';
  static const LOGIN = '/login';
  static const DASHBOARD = '/dashboard';

  static const INVENTORY = '/inventory';
  static const ORDERS = '/orders';
  static const USERS = '/users';

  ///Client Order
  static const CLIENT_ORDER = '/make-order';
}
