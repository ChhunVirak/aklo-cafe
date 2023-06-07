import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/core/firebase_core/notification_core/firebase_notification_helper.dart';
import 'package:aklo_cafe/util/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../inventory/inventory.dart';

class ClientOrderScreen extends StatelessWidget {
  const ClientOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: AllCoffeeScreen(),
          ),
          Container(
            height: 70,
            color: AppColors.deepBackgroundColor,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.defaultPadding,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Total : 4.5\$',
                    style: AppStyle.large,
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: context.width * 0.4),
                  child: CustomButton(
                    onPressed: () {
                      NotificationHelper.instance
                          .showNotification('New Order', 'body');
                    },
                    backgroundColor: Colors.green,
                    name: 'Check Out',
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
