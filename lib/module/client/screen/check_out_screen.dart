import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/core/firebase_core/notification_core/firebase_admin_notification.dart';
import 'package:aklo_cafe/module/client/controller/client_order_controller.dart';
import 'package:aklo_cafe/util/alerts/app_snackbar.dart';
import 'package:aklo_cafe/util/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(ClientOrderController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders #3403E2'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: orderController.getList.entries
                  .map(
                    (e) => ListTile(
                      title: Text(e.value.drinkModel!.name),
                      subtitle: const Text('No Sugar'),
                      trailing: Text('x ${e.value.unit}'),
                    ),
                  )
                  .toList(),
            ),
          ),
          SafeArea(
            minimum: const EdgeInsets.all(Sizes.defaultPadding),
            child: CustomButton(
              onPressed: () {
                showSuccessSnackBar(
                    title: 'Order Sent',
                    description: 'Your order has been placed successfully');
                AdminNotificationManager.instance.sentNotification(
                    'Please make me a drink',
                    'Total Price \$${orderController.total.toStringAsFixed(2)}');
              },
              name: 'Make Order',
            ),
          ),
        ],
      ),
    );
  }
}
