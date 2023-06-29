import 'dart:io';

import 'package:aklo_cafe/module/inventory/components/loading_scaffold.dart';
import 'package:aklo_cafe/module/inventory/controller/inventory_controller.dart';
import 'package:aklo_cafe/util/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/l10n.dart';
import '../../../util/widgets/custom_image_picker_box.dart';
import '../../../util/widgets/custom_textfield.dart';

class AddCategory extends StatefulWidget {
  final String? id;
  const AddCategory({super.key, this.id});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final controller = Get.put(InventoryController());

  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    controller.initialCategoryForm(widget.id);
    super.initState();
  }

  @override
  void dispose() {
    controller.tempCategoryImage = null;
    controller.categoryFile = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.initialCategoryFormLoading.value
          ? LoadingScaffold()
          : Scaffold(
              appBar: AppBar(
                title: Text(S.current.addCategory),
              ),
              resizeToAvoidBottomInset: true,
              body: SafeArea(
                minimum: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: FocusScope(
                          child: Form(
                            key: _form,
                            child: Column(
                              children: [
                                GetBuilder(
                                    init: controller,
                                    initState: (_) {
                                      ///Clear Image
                                      controller.categoryFile = null;
                                    },
                                    builder: (_) {
                                      return ImagePickerBox(
                                        defaultNetWorkImage:
                                            controller.tempCategoryImage,
                                        onSelectImage: (value) async {
                                          if (value != null) {
                                            controller.categoryFile =
                                                File(value);

                                            debugPrint('Image Compressed');
                                          }
                                        },
                                      );
                                    }),

                                CustomTextField(
                                  controller: controller
                                      .categoryEnglishNameTxtcontroller,
                                  label: S.current.category_name_en,
                                  require: true,
                                  textInputAction: TextInputAction.next,
                                  validator: (v) {
                                    if (v == '') {
                                      return S.current
                                          .category_name_en_ValidateMessage;
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextField(
                                  controller:
                                      controller.categoryKhmerNameTxtcontroller,
                                  label: S.current.category_name_kh,
                                  require: true,
                                  textInputAction: TextInputAction.next,
                                  validator: (v) {
                                    if (v == '') {
                                      return S.current
                                          .category_name_kh_ValidateMessage;
                                    }
                                    return null;
                                  },
                                ),

                                // const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    CustomButton(
                      onPressed: () async {
                        // controller.uploadFile('',controller.categoryFile);
                        final noError = _form.currentState?.validate();
                        if (noError == true) {
                          // controller.deleteImage('dasd', 'asda');
                          if (widget.id == null) {
                            await controller.addCategory();
                          } else {
                            await controller.updateCategory(widget.id);
                          }
                        }
                      },
                      name:
                          widget.id == null ? S.current.add : S.current.update,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
