import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/module/inventory/controller/inventory_controller.dart';
import 'package:aklo_cafe/util/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/snackbar/app_snackbar.dart';
import '../../../util/widgets/custom_textfield.dart';

class AddDrinkScreen extends StatefulWidget {
  const AddDrinkScreen({super.key});

  @override
  State<AddDrinkScreen> createState() => _AddDrinkScreenState();
}

class _AddDrinkScreenState extends State<AddDrinkScreen> {
  final controller = Get.find<InventoryController>();
  void _showCategories(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (popContext) => Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              'Drink Categories',
            ),
            backgroundColor: AppColors.secondaryColor,
            centerTitle: true,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: controller.categories.length,
              itemBuilder: (_, int index) => ListTile(
                onTap: () {
                  Navigator.pop(popContext);
                },
                title: Text(
                  controller.categories[index],
                  style: AppStyle.medium,
                ),
                tileColor: AppColors.backgroundColor,
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: Sizes.tablePadding,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.addDrink),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        minimum: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: controller.drinkNameTxTcontroller,
                        label: 'Drink Name',
                        require: true,
                        textInputAction: TextInputAction.next,
                        validator: (v) {
                          if (v == '') {
                            return Strings.drinkNameValidateMessage;
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        controller: controller.drinkCategoryTxTcontroller,
                        label: 'Category',
                        require: true,
                        textInputAction: TextInputAction.next,
                        suffixIcon: FocusScope(
                          canRequestFocus: false,
                          child: IconButton(
                            focusNode: null,
                            onPressed: () {
                              _showCategories(context);
                            },
                            icon: const Icon(
                              Icons.format_list_numbered_rounded,
                              size: 25,
                            ),
                          ),
                        ),
                        validator: (v) {
                          if (v == '') {
                            return Strings.drinkCategoryValidateMessage;
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        controller: controller.unitPriceTxTcontroller,
                        label: 'Unit Price',
                        require: true,
                        textInputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        textInputAction: TextInputAction.next,
                        validator: (v) {
                          if (v == '') {
                            return Strings.drinkUnitPriceValidateMessage;
                          }

                          return null;
                        },
                        suffixIcon: const Icon(Icons.attach_money_rounded),
                      ),
                      CustomTextField(
                        controller: controller.amountTxTcontroller,
                        label: 'Amount',
                        require: true,
                        textInputType: TextInputType.number,
                        validator: (v) {
                          if (v == '') {
                            return Strings.drinkTotalAmountValidateMessage;
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
            CustomButton(
              onPressed: () async {
                final noError = _form.currentState?.validate();
                if (noError == true) {
                  final success = await controller.addDrink();
                  if (success == true && context.mounted) {
                    controller.clear();
                    showSuccessSnackBar(
                      title: 'Success',
                      description: 'New drink has been added successfully.',
                    );
                    Navigator.pop(context);
                  }
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
