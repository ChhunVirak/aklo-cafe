import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/module/client/controller/client_order_controller.dart';
import 'package:aklo_cafe/module/client/screen/check_out_screen.dart';
import 'package:aklo_cafe/util/alerts/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

import '../../inventory/inventory.dart';

class ClientOrderScreen extends StatefulWidget {
  const ClientOrderScreen({super.key});

  @override
  State<ClientOrderScreen> createState() => _ClientOrderScreenState();
}

class _ClientOrderScreenState extends State<ClientOrderScreen> {
  final controller = Get.put(ClientOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Column(
          children: [
            const Expanded(child: AllCoffeeScreen()),
            Container(
              padding: const EdgeInsets.all(20),
              // height: context.height * 0.2,
              decoration:
                  const BoxDecoration(color: AppColors.deepBackgroundColor),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Total ${controller.total.toStringAsFixed(2)}\$',
                      style: AppStyle.medium,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (controller.total <= 0) {
                        showErrorSnackBar(
                            title: "Please add drink",
                            description: 'a drink is required to make order');
                        return;
                      }
                      Get.to(const CheckOutScreen());
                    },
                    icon: const Icon(PhosphorIcons.shopping_cart),
                    label: const Text('Check Out'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
