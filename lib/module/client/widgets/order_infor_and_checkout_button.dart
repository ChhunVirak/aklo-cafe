import 'dart:ui' show FontFeature;

import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

import '../../../constant/resources.dart';
import '../../../generated/l10n.dart';
import '../../../util/alerts/app_snackbar.dart';
import '../../../util/function/format_function.dart';
import '../controller/client_order_controller.dart';

class OrderInfoAndCheckOut extends StatelessWidget {
  const OrderInfoAndCheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClientOrderController());
    return Container(
      padding: EdgeInsets.only(left: Sizes.textPadding),
      margin:
          EdgeInsets.only(left: Sizes.textPadding, right: Sizes.textPadding),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(50),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Badge(
            label: Text(controller.totalDrinkUnitCount.toString()),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                PhosphorIcons.shopping_cart,
                color: AppColors.txtLightColor,
              ),
            ),
          ),
          10.sw,
          Text(
            '${S.current.total}: ',
            style: AppStyle.small.copyWith(
              color: AppColors.txtLightColor,
              fontFeatures: const [FontFeature.proportionalFigures()],
            ),
          ),
          Expanded(
            child: Text(
              '\$${formatCurrency(controller.total)}',
              style: AppStyle.medium.copyWith(
                color: AppColors.txtLightColor,
              ),
            ),
          ),
          Material(
            borderRadius: BorderRadius.circular(50),
            child: InkWell(
              onTap: () {
                if (controller.total <= 0) {
                  showErrorSnackBar(
                      title: S.current.add_drink_message,
                      description: S.current.add_drink_message_des);
                  return;
                }
                controller.screen(Screen.checkout);
                controller.update(['Screen']);
              },
              child: Ink(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: Sizes.defaultPadding),
                decoration: BoxDecoration(
                  color: controller.totalDrinkUnitCount > 0
                      ? Colors.red
                      : Colors.grey,
                ),
                child: Center(
                  child: Text(
                    S.current.check_out,
                    style: AppStyle.large.copyWith(
                      color: AppColors.txtLightColor,
                      fontFeatures: const [FontFeature.proportionalFigures()],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
