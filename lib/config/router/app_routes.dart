// ignore_for_file: non_constant_identifier_names, constant_identifier_names, unused_field
part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASHSCREEN;

  static const LOGIN = _Paths.LOGIN;
  static const DASHBOARD = _Paths.DASHBOARD;
  static get INVENTORY => path.join(_Paths.DASHBOARD, _Paths.INVENTORY);
  static const ALL_DRINK = _Paths.ALL_DRINKS;
  static const EDIT_DRINK = _Paths.ADD_DRINK;
  static const ADD_CATEGORY = _Paths.ADD_CATEGORY;
  static const USER = _Paths.USERS;
  static const ABOUT_US = _Paths.ABOUT_US;
  static const CATEGORY = _Paths.CATEGORY;
  static const ORDERS = _Paths.ORDERS;

  ///Client Order
  static const CLIENT_ORDER = _Paths.CLIENT_ORDER;
  static const CLIENT_STATUS = _Paths.CLIENT_STATUS;
}

abstract class _Paths {
  _Paths._();
  static const SPLASHSCREEN = '/splash';
  static const LOGIN = '/login';
  static const DASHBOARD = '/';

  static const INVENTORY = 'inventory';
  static const ORDERS = 'orders';

  static const USERS = 'users';
  static const ABOUT_US = 'about-us';
  static const PROFILE = 'profile';
  static const ALL_DRINKS = 'all-drink';
  static const ADD_DRINK = 'add-drink';
  static const CATEGORY = 'category';
  static const ADD_CATEGORY = 'add-category';

  ///Client Order
  static const CLIENT_ORDER = '/make-order';
  static const CLIENT_STATUS = '/done-order';
}
