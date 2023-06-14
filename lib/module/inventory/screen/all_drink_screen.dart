import 'package:aklo_cafe/config/languages/lang_font_controller.dart';
import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/module/client/controller/client_order_controller.dart';
import 'package:aklo_cafe/module/inventory/controller/inventory_controller.dart';
import 'package:aklo_cafe/module/inventory/model/drink_model.dart';
import 'package:aklo_cafe/util/alerts/app_dialog.dart';
import 'package:aklo_cafe/util/alerts/app_modal_bottomsheet.dart';
import 'package:aklo_cafe/util/alerts/app_snackbar.dart';
import 'package:aklo_cafe/util/extensions/responsive/responsive_extension.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:aklo_cafe/util/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/router/app_pages.dart';
import '../../../generated/l10n.dart';
import '../../../util/widgets/app_circular_loading.dart';
import '../components/drink_card.dart';
import '../model/category_model.dart';

class AllCoffeeScreen extends GetView<InventoryController> {
  const AllCoffeeScreen({super.key});

  Color _chipBgColor(bool selected) =>
      selected ? AppColors.secondaryColor : AppColors.deepBackgroundColor;

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(ClientOrderController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.allCoffeeTitle),
      ),
      body: GetBuilder(
          init: Get.put(InventoryController()),
          initState: (_) {
            controller.currentCategory.value = 'All';
          },
          builder: (_) {
            return Column(
              children: [
                ///Tabar
                StreamBuilder(
                  stream: controller.categoryDb.snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CustomCircularLoading(),
                      );
                    }
                    if (snapshot.hasData) {
                      final listData = snapshot.data?.docs
                          .map((e) => CategoryModel.fromMap(e.data()))
                          .toList();
                      return SizedBox(
                        width: context.width,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.defaultPadding,
                              vertical: Sizes.tablePadding),
                          scrollDirection: Axis.horizontal,
                          child: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: Sizes.textPadding),
                                  child: ActionChip(
                                    backgroundColor: _chipBgColor(
                                        controller.currentCategory.value ==
                                            'All'),
                                    labelStyle: AppStyle.medium.copyWith(
                                        color:
                                            controller.currentCategory.value ==
                                                    'All'
                                                ? AppColors.txtLightColor
                                                : null),
                                    onPressed: () {
                                      controller.currentCategory.value = 'All';
                                    },
                                    label: Text(S.current.all),
                                    shape: const StadiumBorder(),
                                  ),
                                ),
                                ...listData
                                        ?.map(
                                          (e) => Padding(
                                            padding: const EdgeInsets.only(
                                                right: Sizes.textPadding),
                                            child: ActionChip(
                                              backgroundColor: _chipBgColor(
                                                  controller.currentCategory
                                                          .value ==
                                                      e.nameEn),
                                              onPressed: () {
                                                controller.currentCategory
                                                    .value = e.nameEn;
                                              },
                                              label: Text(Get.locale ==
                                                      Langs.english.locale
                                                  ? e.nameEn
                                                  : e.nameKh),
                                              labelStyle: AppStyle.medium
                                                  .copyWith(
                                                      color: controller
                                                                  .currentCategory
                                                                  .value ==
                                                              e.nameEn
                                                          ? AppColors
                                                              .txtLightColor
                                                          : null),
                                            ),
                                          ),
                                        )
                                        .toList() ??
                                    const []
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                Expanded(
                  child: Obx(
                    () => StreamBuilder(
                      stream: controller
                          .drinkofCategory(controller.currentCategory.value),
                      builder: (_, snapshot) {
                        debugPrint('Snapshot => ${snapshot.connectionState}');
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        debugPrint('Error ${snapshot.hasData}');
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text(
                              'No Data',
                              style: AppStyle.large,
                            ),
                          );
                        }

                        if (snapshot.hasData) {
                          final listData = snapshot.data?.docs
                              .map((e) => DrinkModel.fromMap(e.data()))
                              .toList();
                          return GetBuilder(
                              init: orderController,
                              builder: (_) {
                                return GridView.builder(
                                  padding: const EdgeInsets.all(Sizes.padding),
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate: _deligate(context),
                                  itemCount: listData?.length ?? 0,
                                  itemBuilder: (_, index) {
                                    final name = listData?[index].name;
                                    // final img = listData[index].image;
                                    final unitPrice =
                                        listData?[index].unitPrice;
                                    final qty = listData?[index].amount;
                                    final id = listData?[index].id;

                                    return GestureDetector(
                                      onTap: () {
                                        if (GetPlatform.isWeb) {
                                          ///Client Order
                                          debugPrint('Hello');
                                        } else {
                                          showCustomModalBottomSheet(
                                            Container(
                                              padding: const EdgeInsets.all(
                                                  Sizes.defaultPadding),
                                              // color: Colors.white,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CustomButton(
                                                    onPressed: () {
                                                      //TODO : initial Data to Edit
                                                      controller
                                                          .initialDrinkForEdit(
                                                              listData?[index]);
                                                      final param =
                                                          <String, String>{}
                                                            ..addIf(
                                                              id != null,
                                                              'id',
                                                              id!,
                                                            );

                                                      Get.back();

                                                      Get.toNamed(
                                                        Routes.EDIT_DRINK,
                                                        parameters: param,
                                                      );
                                                    },
                                                    name: 'Edit',
                                                  ),
                                                  Sizes.defaultPadding.sh,
                                                  CustomButton(
                                                    onPressed: () {
                                                      showCustomDialog(
                                                        title: 'Confirm!',
                                                        description:
                                                            'Are you sure want to delete $name',
                                                        actions: [
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              await controller
                                                                  .drinkDb
                                                                  .doc(listData?[
                                                                          index]
                                                                      .id)
                                                                  .delete();
                                                              Get.back();
                                                              Get.back();
                                                              showErrorSnackBar(
                                                                  title: S
                                                                      .current
                                                                      .success,
                                                                  description: S
                                                                      .current
                                                                      .delete_success);
                                                            },
                                                            child: const Text(
                                                                'Yes'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'No'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                    backgroundColor: Colors.red,
                                                    name: 'Delete',
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: DrinkCard(
                                        name: name,
                                        image:
                                            'https://cdn.shopify.com/s/files/1/0298/4581/5429/products/ReusableCup_grande.png?v=1578631807',
                                        unitPrice: unitPrice,
                                        qty: qty,
                                        amount: orderController.getAmount(id),
                                        onPressedAdd: !GetPlatform.isWeb
                                            ? () {
                                                orderController
                                                    .addItem(listData?[index]);
                                              }
                                            : null,
                                        onPressedRemove: !GetPlatform.isWeb
                                            ? () {
                                                orderController.removeItem(
                                                    listData?[index]);
                                              }
                                            : null,
                                      ),
                                    );
                                  },
                                );
                              });
                        }

                        return const Center(
                          child: Text('Something went wrong'),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  SliverGridDelegate _deligate(BuildContext context) =>
      SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1 / 1.4,
        crossAxisCount: context.responsive<int>(2, sm: 2, md: 3, lg: 4, xl: 5),
        mainAxisSpacing: Sizes.padding,
        crossAxisSpacing: Sizes.padding,
      );
}
