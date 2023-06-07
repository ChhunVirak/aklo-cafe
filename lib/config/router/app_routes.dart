// ignore_for_file: non_constant_identifier_names, constant_identifier_names, unused_field
part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASHSCREEN;

  static const LOGIN = _Paths.LOGIN;
  static const DASHBOARD = _Paths.DASHBOARD;
  static const INVENTORY = _Paths.DASHBOARD + _Paths.INVENTORY;
  static const EDIT_DRINK = INVENTORY + _Paths.ALL_DRINKS + _Paths.ADD_DRINK;

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
  static const ALL_DRINKS = '/all-drink';
  static const ADD_DRINK = '/add-drink';

  ///Client Order
  static const CLIENT_ORDER = '/make-order';
}
