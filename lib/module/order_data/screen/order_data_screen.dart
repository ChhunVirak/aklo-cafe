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

  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.data),
        // actions: [
        //   TextButton(
        //     onPressed: () async {
        //       final selectedDate = await showDatePicker(
        //         context: context,
        //         initialDate: _date,
        //         firstDate: DateTime(DateTime.now().year - 5),
        //         lastDate: DateTime(DateTime.now().year + 5),
        //       );
        //       if (selectedDate != null) {
        //         _date = selectedDate;
        //         setState(() {});
        //       }
        //     },
        //     // icon: Icon(PhosphorIcons.calendar),
        //     child: Row(
        //       children: [
        //         Text(_date.displayDate),
        //         4.sw,
        //         Icon(PhosphorIcons.caret_down)
        //       ],
        //     ),
        //   ),
        //   10.sw,
        // ],
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
                Row(
                  children: [
                    Text(S.current.newOrder + ' :'),
                    Sizes.textSpaceW,
                    StreamBuilder(
                      stream: adminOrderController.orderOf(Status.neworder),
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                              snapshot.data?.docs.length.toString() ?? '',
                              style: AppStyle.large);
                        }
                        return SizedBox.shrink();
                      },
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(S.current.accept + ' :'),
                    Sizes.textSpaceW,
                    StreamBuilder(
                      stream: adminOrderController.orderOf(Status.confirm),
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                              snapshot.data?.docs.length.toString() ?? '',
                              style: AppStyle.large);
                        }
                        return SizedBox.shrink();
                      },
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(S.current.cancelled + ' :'),
                    Sizes.textSpaceW,
                    StreamBuilder(
                      stream: adminOrderController.orderOf(Status.cancel),
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                              snapshot.data?.docs.length.toString() ?? '',
                              style: AppStyle.large);
                        }
                        return SizedBox.shrink();
                      },
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(S.current.done + ' :'),
                    Sizes.textSpaceW,
                    StreamBuilder(
                      stream: adminOrderController.orderOf(Status.done),
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                              snapshot.data?.docs.length.toString() ?? '',
                              style: AppStyle.large);
                        }
                        return SizedBox.shrink();
                      },
                    )
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
