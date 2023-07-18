import 'dart:ui' as ui;

import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/client/model/order_model.dart';
import 'package:aklo_cafe/module/order/controller/admin_order_controller.dart';
import 'package:aklo_cafe/util/alerts/app_snackbar.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:aklo_cafe/util/widgets/app_circular_loading.dart';
import 'package:aklo_cafe/util/widgets/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../../../util/alerts/app_dialog.dart';
import '../component/invoice.dart';

class ViewInvoice extends StatefulWidget {
  final String? id;
  const ViewInvoice({
    super.key,
    this.id,
  });

  @override
  State<ViewInvoice> createState() => _ViewInvoiceState();
}

class _ViewInvoiceState extends State<ViewInvoice> {
  final GlobalKey _globalKey = GlobalKey();

  Future<void> _saveInvoice() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData =
        await (image.toByteData(format: ui.ImageByteFormat.png));
    if (byteData != null) {
      final result = await ImageGallerySaver.saveImage(
        byteData.buffer.asUint8List(),
        quality: 100,
      );
      showSuccessSnackBar(
          title: S.current.success, description: S.current.save_img_msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    final adminOrderController = Get.put(AdminOrderController());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id.toString().toUpperCase()),
      ),
      body: StreamBuilder(
        stream: adminOrderController.orderDataOfId(widget.id),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CustomCircularLoading(),
            );
          }
          if (snapshot.data == null ||
              snapshot.hasError ||
              snapshot.data!.data() == null) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          if (snapshot.hasData) {
            final OrderModel orderModel =
                OrderModel.fromMap(snapshot.data!.data()!);
            return SafeArea(
              minimum: const EdgeInsets.only(
                bottom: Sizes.defaultPadding,
                left: Sizes.defaultPadding,
                right: Sizes.defaultPadding,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: RepaintBoundary(
                        key: _globalKey,
                        child: Invoice(
                          orderModel: orderModel,
                        ),
                      ),
                    ),
                  ),
                  10.sh,
                  if (orderModel.status == Status.done)
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.maxFinite, 50),
                        backgroundColor: AppColors.secondaryColor,
                      ),
                      onPressed: () async {
                        await _saveInvoice();
                        //Click Print
                      },
                      label: Text(
                        'Print',
                        style: AppStyle.medium.copyWith(
                            color: AppColors.txtLightColor,
                            fontVariations: [Sizes.weightL]),
                      ),
                      icon: const Icon(
                        PhosphorIcons.printer,
                        color: AppColors.txtLightColor,
                      ),
                    ),
                  if (orderModel.status == Status.confirm)
                    CustomButton(
                      onPressed: () {
                        adminOrderController.onClickConfirm(widget.id);
                      },
                      name: S.current.done,
                      backgroundColor: Colors.green,
                    ),
                  if (orderModel.status == Status.neworder)
                    Row(
                      children: [
                        IconButton(
                          visualDensity: VisualDensity.comfortable,
                          padding: const EdgeInsets.all(5),
                          onPressed: () {
                            showCustomDialog(
                              title: 'Confirm!',
                              description:
                                  'Are you sure want to cancel this order',
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    adminOrderController
                                        .onClickCancel(widget.id);
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
                          icon: const Icon(
                            PhosphorIcons.x_circle_bold,
                            size: 35,
                            color: Colors.red,
                          ),
                        ),
                        10.sw,
                        Expanded(
                          child: CustomButton(
                            onPressed: () {
                              adminOrderController.onClickAccept(widget.id);
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
          return const Text('Something went wrong!');
        },
      ),
    );
  }
}
