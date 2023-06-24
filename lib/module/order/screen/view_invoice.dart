import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/client/model/order_model.dart';
import 'package:aklo_cafe/module/order/controller/admin_order_controller.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:aklo_cafe/util/widgets/app_circular_loading.dart';
import 'package:aklo_cafe/util/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

import '../../../util/alerts/app_dialog.dart';
import '../component/invoice.dart';

class ViewInvoice extends StatelessWidget {
  final String? id;
  const ViewInvoice({
    super.key,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    final adminOrderController = Get.put(AdminOrderController());
    return Scaffold(
      appBar: AppBar(
        title: Text(id.toString().toUpperCase()),
      ),
      body: StreamBuilder(
        stream: adminOrderController.orderDataOfId(id),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CustomCircularLoading(),
            );
          }
          if (snapshot.data == null ||
              snapshot.hasError ||
              snapshot.data!.data() == null)
            return Center(
              child: Text('Something went wrong'),
            );
          if (snapshot.hasData) {
            final OrderModel orderModel =
                OrderModel.fromMap(snapshot.data!.data()!);
            return SafeArea(
              minimum: EdgeInsets.only(
                bottom: Sizes.defaultPadding,
                left: Sizes.defaultPadding,
                right: Sizes.defaultPadding,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Invoice(
                      orderModel: orderModel,
                    ),
                  ),
                  10.sh,
                  if (orderModel.status == Status.confirm)
                    CustomButton(
                      onPressed: () {
                        adminOrderController.onClickConfirm(id);
                      },
                      name: S.current.done,
                      backgroundColor: Colors.green,
                    ),
                  if (orderModel.status == Status.neworder)
                    Row(
                      children: [
                        IconButton(
                          visualDensity: VisualDensity.comfortable,
                          padding: EdgeInsets.all(5),
                          onPressed: () {
                            showCustomDialog(
                              title: 'Confirm!',
                              description:
                                  'Are you sure want to cancel this order',
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    adminOrderController.onClickCancel(id);
                                    Get.back();

                                    // showErrorSnackBar(
                                    //     title: S
                                    //         .current
                                    //         .success,
                                    //     description: S
                                    //         .current
                                    //         .delete_success);
                                  },
                                  child: Text(S.current.yes),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(S.current.cancel),
                                ),
                              ],
                            );
                          },
                          icon: Icon(
                            PhosphorIcons.x_circle_bold,
                            size: 35,
                            color: Colors.red,
                          ),
                        ),
                        10.sw,
                        Expanded(
                          child: CustomButton(
                            onPressed: () {
                              adminOrderController.onClickAccept(id);
                            },
                            name: S.current.accept,
                          ),
                        ),
                      ],
                    )
                ],
              ),
            );
          }
          return Text('Something went wrong!');
        },
      ),
    );
  }
}
