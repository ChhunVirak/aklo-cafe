import 'package:get/get.dart';

import '../../module/auth/screen/login_screen.dart';
import '../../module/auth/screen/splash_screen.dart';
import '../../module/auth/screen/users_screen.dart';
import '../../module/home/screen/dashboard.dart';
import '../../module/inventory/inventory.dart';
import '../../module/inventory/screen/inventory_screen.dart';
import '../../module/order/screen/orders_screen.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashBoard(),
      children: [
        GetPage(
          name: _Paths.ORDERS,
          page: () => const OrderScreen(),
        ),
        GetPage(
          name: _Paths.INVENTORY,
          binding: InventoryBinding(),
          page: () => const Inventory(),
        ),
        GetPage(
          name: _Paths.USERS,
          page: () => const UsersScreen(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => const SplashScreen(),
    ),
  ];
}

class InventoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InventoryController());
  }
}
