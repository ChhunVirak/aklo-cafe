import 'dart:io';

import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/module/inventory/controller/inventory_controller.dart';
import 'package:aklo_cafe/util/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/l10n.dart';
import '../../../util/widgets/custom_image_picker_box.dart';
import '../../../util/widgets/custom_textfield.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final controller = Get.find<InventoryController>();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.addCategory),
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
                            builder: (context) {
                              return ImagePickerBox(
                                onSelectImage: (value) async {
                                  if (value != null) {
                                    controller.categoryFile = File(value);

                                    debugPrint('Image Compressed');
                                  }
                                },
                              );
                            }),

                        CustomTextField(
                          controller: controller.categoryNameTxtcontroller,
                          label: 'Category Name',
                          require: true,
                          textInputAction: TextInputAction.next,
                          validator: (v) {
                            if (v == '') {
                              return S
                                  .current.categoryNameAmountValidateMessage;
                            }
                            return null;
                          },
                        ),

                        CustomTextField(
                          controller:
                              controller.categoryDescriptionTxtcontroller,
                          label: 'Description',
                          textInputAction: TextInputAction.done,
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

                  await controller.addCategory();
                }
              },
              name: 'Add',
            ),
          ],
        ),
      ),
    );
  }
}
