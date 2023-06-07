import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/module/inventory/controller/inventory_controller.dart';
import 'package:aklo_cafe/module/inventory/model/category_model.dart';
import 'package:aklo_cafe/util/alerts/app_modal_bottomsheet.dart';
import 'package:aklo_cafe/util/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/l10n.dart';
import '../../../util/widgets/custom_textfield.dart';

class AddDrinkScreen extends StatefulWidget {
  final String? id;
  const AddDrinkScreen({
    super.key,
    this.id,
  });

  @override
  State<AddDrinkScreen> createState() => _AddDrinkScreenState();
}

class _AddDrinkScreenState extends State<AddDrinkScreen> {
  final controller = Get.find<InventoryController>();
  Future<void> _showCategories(BuildContext context) async {
    await showCustomModalBottomSheet(
      ColoredBox(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(Sizes.defaultPadding),
              // decoration: const BoxDecoration(
              color: AppColors.secondaryColor,
              //   borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(30),
              //     topRight: Radius.circular(30),
              //   ),
              // ),
              alignment: Alignment.center,
              child: Text(
                'Drink Categories',
                style: AppStyle.large.copyWith(color: AppColors.txtLightColor),
              ),
            ),
            // const Divider(
            //   height: 0,
            //   color: AppColors.txtDarkColor,
            // ),
            Expanded(
                child: StreamBuilder(
              stream: controller.categoryDb.snapshots(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  final cetegoryList = snapshot.data?.docs
                          .map((e) => CategoryModel.fromMap(e.data()))
                          .toList() ??
                      [];
                  return ListView.separated(
                    itemCount: cetegoryList.length,
                    itemBuilder: (_, index) => InkWell(
                      onTap: () {
                        controller.drinkCategoryTxTcontroller.text =
                            cetegoryList[index].name;
                        Navigator.pop(context);
                      },
                      child: Ink(
                        padding: const EdgeInsets.all(Sizes.defaultPadding),
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Text(
                          cetegoryList[index].name,
                          style: AppStyle.medium,
                        ),
                      ),
                    ),
                    separatorBuilder: (_, __) => const Divider(
                      thickness: 0.5,
                      color: AppColors.txtDarkColor,
                      height: 0,
                    ),
                  );
                }
                return const Text('Empty');
              },
            )),
          ],
        ),
      ),
    );
  }

  static final GlobalKey<FormState> _form = GlobalKey<FormState>();

  double sugar = 0;
  double ice = 0;

  int levelCal(double value) => (value * 100).toInt();

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
                padding: const EdgeInsets.only(top: Sizes.defaultPadding),
                child: Form(
                  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: controller.drinkNameTxTcontroller,
                        label: 'Drink Name',
                        require: true,
                        textInputAction: TextInputAction.next,
                        validator: (v) {
                          if (v == '') {
                            return S.current.drinkNameValidateMessage;
                          }
                          return null;
                        },
                      ),
                      Focus(
                        onFocusChange: (_) {
                          debugPrint('statement $_');
                          if (_) {
                            _showCategories(context);
                          }
                        },
                        child: CustomTextField(
                          onTap: () {
                            _showCategories(context).then((value) {
                              FocusScope.of(context).nextFocus();
                            });
                          },
                          enable: false,
                          controller: controller.drinkCategoryTxTcontroller,
                          label: 'Category',
                          require: true,
                          textInputAction: TextInputAction.next,
                          suffixIcon: FocusScope(
                            canRequestFocus: false,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.expand_more_rounded,
                                size: 25,
                              ),
                            ),
                          ),
                          validator: (v) {
                            if (v == '') {
                              return S.current.drinkCategoryValidateMessage;
                            }
                            return null;
                          },
                        ),
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
                            return S.current.drinkUnitPriceValidateMessage;
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
                            return S.current.drinkTotalAmountValidateMessage;
                          }
                          return null;
                        },
                      ),

                      /*
                      Text(
                        'Sugar Level : ${levelCal(sugar)}%',
                        style: AppStyle.medium,
                      ),
                      Slider(
                        value: sugar,
                        divisions: 4,
                        activeColor: AppColors.mainColor,
                        inactiveColor: AppColors.backgroundColor,
                        label: 'Sugar ${levelCal(sugar)}%',
                        onChanged: (_) {
                          setState(() {
                            sugar = _;
                          });
                        },
                      ),
                      Text(
                        'Ice Level : ${levelCal(ice)}%',
                        style: AppStyle.medium,
                      ),
                      Slider(
                        value: ice,
                        divisions: 4,
                        activeColor: AppColors.mainColor,
                        inactiveColor: AppColors.backgroundColor,
                        label: 'Sugar ${levelCal(ice)}%',
                        onChanged: (_) {
                          setState(() {
                            ice = _;
                          });
                        },
                      ),
                      */
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
                  if (widget.id == null) {
                    await controller.addDrink();
                  } else {
                    await controller.updateDrink(widget.id);
                  }
                }
              },
              name: widget.id == null ? 'Add' : 'Update',
            ),
          ],
        ),
      ),
    );
  }
}
