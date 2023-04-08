import 'package:aklo_cafe/module/home/controller/dashboard_controller.dart';
import 'package:get/get.dart';

import '../module/inventory/controller/inventory_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashBoardController());
    Get.lazyPut(() => InventoryController());
  }
}
