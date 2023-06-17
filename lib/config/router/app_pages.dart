import 'package:aklo_cafe/module/client/screen/client_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as path;

import '../../module/auth/screen/login_screen.dart';
import '../../module/auth/screen/splash_screen.dart';
import '../../module/auth/screen/users_screen.dart';
import '../../module/home/screen/dashboard.dart';
import '../../module/inventory/inventory.dart';
import '../../module/inventory/screen/inventory_screen.dart';
import '../../module/order/screen/orders_screen.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

final adminRouter = GoRouter(
  navigatorKey: Get.key,
  initialLocation: Routes.SPLASH,
  routes: <GoRoute>[
    GoRoute(
      path: _Paths.SPLASHSCREEN,
      builder: (_, state) => const SplashScreen(),
    ),
    GoRoute(
      path: _Paths.CLIENT_ORDER,
      builder: (_, state) => const ClientOrderScreen(),
    ),
    GoRoute(
      path: _Paths.LOGIN,
      builder: (_, state) => const LoginScreen(),
    ),
    GoRoute(
      path: _Paths.DASHBOARD,
      builder: (_, state) => const DashBoard(),
      routes: [
        GoRoute(
          path: _Paths.ORDERS,
          builder: (_, state) => const OrderScreen(),
        ),
        GoRoute(
          path: _Paths.INVENTORY,
          builder: (_, state) => const Inventory(),
          routes: [
            GoRoute(
              path: _Paths.ALL_DRINKS,
              builder: (_, state) => const AllCoffeeScreen(),
              routes: [
                GoRoute(
                  path: _Paths.ADD_DRINK,
                  builder: (_, state) => AddDrinkScreen(
                    id: state.queryParameters['id'],
                  ),
                ),
              ],
            ),
            GoRoute(
              path: _Paths.ADD_DRINK,
              builder: (_, state) => AddDrinkScreen(
                id: state.queryParameters['id'],
              ),
            ),
          ],
        ),
        GoRoute(
          path: _Paths.USERS,
          builder: (_, state) => const UsersScreen(),
        ),
      ],
    ),
  ],
);

final clientRouter = GoRouter(
  navigatorKey: Get.key,
  initialLocation: Routes.CLIENT_ORDER,
  routes: <GoRoute>[
    GoRoute(
      path: _Paths.CLIENT_ORDER,
      builder: (_, state) => const ClientOrderScreen(),
    ),
  ],
);

class AppPages {
  AppPages._();
  static const INITIAL_ADMIN = Routes.SPLASH;
  static const INITIAL_CLIENT = Routes.CLIENT_ORDER;

  static String get getInitialRoute =>
      GetPlatform.isWeb ? INITIAL_CLIENT : INITIAL_ADMIN;
}

Future<void> pushSubRoute(String destination,
    {Map<String, dynamic>? queryParams}) async {
  debugPrint(
      'Current Location : ${path.join(adminRouter.location, destination)}');
  if (destination.isEmpty) return;
  String route =
      Uri(path: destination, queryParameters: queryParams).toString();
  await adminRouter.push(path.join(adminRouter.location, route));
}
