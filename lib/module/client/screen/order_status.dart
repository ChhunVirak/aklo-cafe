import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/client/screen/order_header.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:aklo_cafe/util/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../order/controller/admin_order_controller.dart';
import '../controller/client_order_controller.dart';
import '../model/order_model.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClientOrderController());
    return Scaffold(
      body: Column(
        children: [
          OrderHeader(),
          Expanded(
            child: StreamBuilder(
                stream: controller.currentOrder,
                builder: (_, snapshot) {
                  final data = snapshot.data?.data();
                  if (snapshot.hasData && data != null) {
                    debugPrint('HAS');
                    final orderModel = OrderModel.fromMap(data);
                    switch (orderModel.status) {
                      case Status.neworder:
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                PhosphorIcons.hourglass,
                                size: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Sizes.padding),
                                child: LinearProgressIndicator(),
                              ),
                              10.sh,
                              Text(
                                'Waiting merchant to confirm!',
                                style: AppStyle.medium,
                              )
                            ],
                          ),
                        );
                      case Status.confirm:
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LottieBuilder.asset(
                                'assets/client/making_coffee.json',
                                width: context.width * 0.8,
                              ),
                              10.sh,
                              Text(
                                'Please wait drink is making!',
                                style: AppStyle.medium,
                              )
                            ],
                          ),
                        );

                      case Status.cancel:
                        return Column(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.close,
                                    size: 50,
                                  ),
                                  10.sh,
                                  Text(
                                    'Your Order has been Canceled!',
                                    style: AppStyle.medium,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.all(Sizes.defaultPadding),
                              child: CustomButton(
                                onPressed: () {
                                  controller.newOrder();
                                },
                                name: S.current.newOrder,
                              ),
                            )
                          ],
                        );

                      case Status.done:
                        return Column(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.done_rounded,
                                    size: 50,
                                  ),
                                  10.sh,
                                  Text(
                                    S.current.drink_done,
                                    style: AppStyle.medium,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.all(Sizes.defaultPadding),
                              child: CustomButton(
                                onPressed: () {
                                  controller.newOrder();
                                },
                                name: S.current.newOrder,
                              ),
                            )
                          ],
                        );
                    }
                  }
                  return Center(
                    child: Text('Error'),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
