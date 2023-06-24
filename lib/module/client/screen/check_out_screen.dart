import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/core/firebase_core/notification_core/firebase_admin_notification.dart';
import 'package:aklo_cafe/generated/l10n.dart';
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
        leading: orderController.showback.value
            ? IconButton(
                onPressed: () {
                  orderController.screen(Screen.order);
                  orderController.update(['Screen']);
                },
                icon: Icon(Icons.arrow_back_rounded),
              )
            : null,
        title: const Text('Orders #3403E2'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: orderController.getList.entries
                    .map(
                      (e) => ListTile(
                        title: Text(e.value.drinkModel!.name),
                        trailing: Text('x ${e.value.unit}'),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          SafeArea(
            minimum: const EdgeInsets.all(Sizes.defaultPadding),
            child: CustomButton(
              onPressed: () async {
                final id = await orderController.submitOrder();

                // clientRouter.go(Routes.CLIENT_STATUS);

                ///Call Save Product to db
                showSuccessSnackBar(
                    title: 'Order Sent',
                    description: 'Your order has been placed successfully');
                AdminNotificationManager.instance.sentNotification(
                    title: 'Please make me a drink',
                    body:
                        'Total Price \$${orderController.total.toStringAsFixed(2)}',
                    id: id);
              },
              name: S.current.make_order,
            ),
          ),
        ],
      ),
    );
  }
}
