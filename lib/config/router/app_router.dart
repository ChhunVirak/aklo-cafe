import 'package:aklo_cafe/module/home/screen/dashboard.dart';
import 'package:get/get.dart';

import '../../module/inventory/screen/inventory_screen.dart';
import 'route_name.dart';

class GetRoutes extends RouteNames {
  List<GetPage> get routes => [
        GetPage(
          name: dashboard,
          page: () => const DashBoard(),
        ),
        GetPage(
          name: inventory,
          page: () => const Inventory(),
        )
      ];
}
