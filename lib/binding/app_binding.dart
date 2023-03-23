import 'package:aklo_cafe/module/home/controller/dashboard_controller.dart';
import 'package:get/get.dart';

import '../module/inventory/controller/coffee_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashBoardController());
    Get.lazyPut(() => InventoryController());
  }
}
