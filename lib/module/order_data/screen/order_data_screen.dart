import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/order/controller/admin_order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDataScreen extends StatefulWidget {
  const OrderDataScreen({super.key});

  @override
  State<OrderDataScreen> createState() => _OrderDataScreenState();
}

class _OrderDataScreenState extends State<OrderDataScreen> {
  final adminOrderController = Get.put(AdminOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(Sizes.defaultPadding),
            padding: EdgeInsets.all(Sizes.defaultPadding),
            decoration: Sizes.containerDecoration,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(S.current.today_Total_Order + ' :'),
                    Sizes.textSpaceW,
                    StreamBuilder(
                      stream: adminOrderController.totalOrder,
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data ?? '', style: AppStyle.large
                              // .copyWith(color: AppColors.txtLightColor),
                              );
                        }
                        return SizedBox.shrink();
                      },
                    )
                  ],
                ),
                Sizes.textSpaceH,
                Row(
                  children: [
                    Text(S.current.today_Total_Order),
                  ],
                ),
                Sizes.textSpaceH,
                Row(
                  children: [
                    Text(S.current.today_Total_Order),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          StreamBuilder(
            builder: (context, snapshot) {
              return SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}
