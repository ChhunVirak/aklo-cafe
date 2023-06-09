import 'package:aklo_cafe/module/auth/controller/auth_controller.dart';
import 'package:aklo_cafe/module/home/controller/dashboard_controller.dart';
import 'package:get/get.dart';

import '../module/client/controller/client_order_controller.dart';
import '../module/inventory/controller/inventory_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // if (!GetPlatform.isWeb) {
    Get.put(AuthController());
    Get.put(DashBoardController(), permanent: true);
    Get.put(() => InventoryController(), permanent: true);
    Get.put(ClientOrderController());
    // }
  }
}
