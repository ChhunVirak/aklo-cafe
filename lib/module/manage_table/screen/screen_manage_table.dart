import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/manage_table/controller/manage_table_controller.dart';
import 'package:aklo_cafe/module/manage_table/model/table_model.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:aklo_cafe/util/widgets/custom_button.dart';
import 'package:aklo_cafe/util/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';

import 'dart:ui' as ui;

import '../../../constant/resources.dart';
import '../../../util/alerts/app_dialog.dart';
import '../../../util/alerts/app_modal_bottomsheet.dart';
import '../../../util/alerts/app_snackbar.dart';

class ScreenManageTable extends StatefulWidget {
  const ScreenManageTable({super.key});

  @override
  State<ScreenManageTable> createState() => _ScreenManageTableState();
}

class _ScreenManageTableState extends State<ScreenManageTable> {
  final _tableController = Get.put(ManageTableController());

  void _showQrWebSite({
    required BuildContext context,
    required String tableNumber,
    required String tableId,
  }) {
    final eMenuLink = 'https://aklo-cafe.web.app/make-order?id=$tableId';
    final GlobalKey _globalKey = GlobalKey();

    Get.dialog(
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.all(30),
                child: RepaintBoundary(
                  key: _globalKey,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: Sizes.boxBorderRadius,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(color: Colors.white),
                          alignment: Alignment.center,
                          child: Text(
                            'Scan code to order',
                            style: AppStyle.large.copyWith(
                              // color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: Sizes.boxBorderRadius,
                          ),
                          margin: const EdgeInsets.only(
                            top: 30,
                            left: 50,
                            right: 50,
                            bottom: 50,
                          ),
                          padding: const EdgeInsets.all(20).copyWith(top: 0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  tableNumber,
                                  style: AppStyle.large.copyWith(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              Image.network(
                                'https://api.qrserver.com/v1/create-qr-code/?size=512x512&data=$eMenuLink',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0).copyWith(top: 0),
              child: CustomButton(
                  onPressed: () async {
                    RenderRepaintBoundary boundary = _globalKey.currentContext!
                        .findRenderObject() as RenderRepaintBoundary;
                    ui.Image image = await boundary.toImage();
                    ByteData? byteData = await (image.toByteData(
                        format: ui.ImageByteFormat.png));
                    if (byteData != null) {
                      await ImageGallerySaver.saveImage(
                        byteData.buffer.asUint8List(),
                        quality: 100,
                      );
                      showSuccessSnackBar(
                          title: S.current.success,
                          description: S.current.save_img_msg);
                    }
                  },
                  name: S.current.print),
            )
          ],
        ),
      ),
    );
  }

  void _addTable({
    required BuildContext context,
    required String? tableNumber,
    required String? tableId,
  }) {
    final _formKey = GlobalKey<FormState>();
    final numberTxtController = TextEditingController()
      ..text = tableNumber ?? '';
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30)
            .copyWith(bottom: 30 + MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: _formKey,
              child: CustomTextField(
                controller: numberTxtController,
                label: S.current.tableNumber,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                textInputType: TextInputType.numberWithOptions(
                  decimal: false,
                ),
                validator: (v) {
                  final number = num.tryParse(v ?? '');
                  if (number == null || number > 99) {
                    return S.current.required;
                  }

                  return null;
                },
              ),
            ),
            CustomButton(
              onPressed: () async {
                final validate = _formKey.currentState?.validate();
                if (validate == true) {
                  if (tableId == null) {
                    final canAdd = await _tableController.addTable(
                      number: int.parse(numberTxtController.text),
                    );
                    if (canAdd) {
                      Navigator.pop(_);
                      showSuccessSnackBar(
                          title: S.current.success,
                          description: S.current.add_success);
                    } else {
                      showErrorSnackBar(
                          title: S.current.fail, description: S.current.fail);
                    }
                  } else {
                    final canAdd = await _tableController.updateTable(
                      id: tableId,
                      number: int.parse(numberTxtController.text),
                    );
                    if (canAdd) {
                      Navigator.pop(_);
                      Navigator.pop(_);
                      showSuccessSnackBar(
                          title: S.current.success,
                          description: S.current.update_success);
                    } else {
                      showErrorSnackBar(
                          title: S.current.fail, description: S.current.fail);
                    }
                  }
                }
              },
              name: tableId == null ? S.current.add : S.current.update,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.manageTable),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTable(context: context, tableNumber: null, tableId: null);
        },
        child: Icon(
          Icons.add_rounded,
        ),
      ),
      body: StreamBuilder<List<TableModel>>(
        stream: _tableController.getAllTables,
        builder: (_, snapshot) {
          final data = snapshot.data;
          if (snapshot.hasData && data != null) {
            return GridView.builder(
              padding: EdgeInsets.all(Sizes.defaultPadding),
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: Sizes.defaultPadding,
                crossAxisSpacing: Sizes.defaultPadding,
              ),
              itemBuilder: (_, index) {
                final table = data[index];
                final number = NumberFormat('00', 'en').format(table.number);
                return GestureDetector(
                  onTap: () {
                    _showQrWebSite(
                      context: context,
                      tableNumber: number,
                      tableId: table.id!,
                    );
                  },
                  onLongPress: () {
                    showCustomModalBottomSheet(
                      Container(
                        padding: const EdgeInsets.all(Sizes.defaultPadding),
                        // color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomButton(
                              onPressed: () {
                                //remove pop up
                                _addTable(
                                  context: context,
                                  tableId: table.id,
                                  tableNumber: number,
                                );
                                // Get.back();
                              },
                              name: S.current.edit,
                            ),
                            Sizes.defaultPadding.sh,
                            CustomButton(
                              onPressed: () async {
                                //TODO: Make available
                                if (table.id == null) return;
                                await _tableController
                                    .makeAvailable(table.id!)
                                    .then((_) {
                                  Navigator.pop(context);
                                });
                              },
                              backgroundColor: Colors.green,
                              name: 'Clear',
                            ),
                            Sizes.defaultPadding.sh,
                            CustomButton(
                              onPressed: () {
                                showCustomDialog(
                                  title: 'Confirm!',
                                  description:
                                      'Are you sure want to delete table?',
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        //TODO : add delete function
                                        if (table.id == null) {
                                          showErrorSnackBar(
                                              title: S.current.fail,
                                              description: S.current.fail);
                                          return;
                                        }
                                        _tableController.deleteTable(
                                            id: table.id!);
                                        Get.back();
                                        Get.back();
                                        showErrorSnackBar(
                                            title: S.current.success,
                                            description:
                                                S.current.delete_success);
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
                              backgroundColor: Colors.red,
                              name: S.current.delete,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: table.currentOrderId == null
                            ? Colors.green
                            : Colors.red,
                        borderRadius: BorderRadiusDirectional.circular(20)
                        // border: Border.all(),
                        ),
                    alignment: Alignment.center,
                    child: Text(
                      number,
                      style: AppStyle.medium.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: AppColors.txtLightColor,
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
