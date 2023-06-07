import 'package:aklo_cafe/module/client/screen/client_order.dart';
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
  static const INITIAL_ADMIN = Routes.SPLASH;
  static const INITIAL_CLIENT = Routes.CLIENT_ORDER;

  static String get getInitialRoute =>
      GetPlatform.isWeb ? INITIAL_CLIENT : INITIAL_ADMIN;

  static final routesClient = <GetPage>[
    GetPage(
      name: _Paths.CLIENT_ORDER,
      page: () => const ClientOrderScreen(),
    )
  ];

  static final routesAdmin = <GetPage>[
    GetPage(
      name: _Paths.CLIENT_ORDER,
      page: () => const ClientOrderScreen(),
    ),
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
          children: [
            GetPage(
              name: _Paths.ALL_DRINKS,
              page: () => const AllCoffeeScreen(),
              children: [
                GetPage(
                  name: _Paths.ADD_DRINK,
                  page: () => AddDrinkScreen(
                    id: Get.parameters['id'],
                  ),
                ),
              ],
            ),
          ],
        ),
        GetPage(
          name: _Paths.USERS,
          page: () => const UsersScreen(),
        ),
        GetPage(
          name: _Paths.ADD_DRINK,
          page: () => const AddDrinkScreen(),
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
