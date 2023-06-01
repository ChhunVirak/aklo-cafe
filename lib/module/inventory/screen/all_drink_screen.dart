import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/module/inventory/controller/inventory_controller.dart';
import 'package:aklo_cafe/module/inventory/model/drink_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/widgets/app_circular_loading.dart';
import '../components/drink_card.dart';
import '../model/category_model.dart';

class AllCoffeeScreen extends GetView<InventoryController> {
  const AllCoffeeScreen({super.key});

  Color _chipBgColor(bool selected) =>
      selected ? AppColors.secondaryColor : AppColors.deepBackgroundColor;

  @override
  Widget build(BuildContext context) {
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
                StreamBuilder(
                  stream: controller.categoryDb.snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CustomCircularLoading(),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.active &&
                        snapshot.hasData) {
                      final listData = snapshot.data?.docs
                          .map((e) => CategoryModel.fromMap(e.data()))
                          .toList();
                      return SizedBox(
                        width: context.width,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.defaultPadding),
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
                                    label: const Text('All'),
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
                                                      e.name),
                                              onPressed: () {
                                                controller.currentCategory
                                                    .value = e.name;
                                              },
                                              label: Text(e.name),
                                              labelStyle: AppStyle.medium
                                                  .copyWith(
                                                      color: controller
                                                                  .currentCategory
                                                                  .value ==
                                                              e.name
                                                          ? AppColors
                                                              .txtLightColor
                                                          : null),
                                              shape: const StadiumBorder(),
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
                        if (snapshot.connectionState ==
                                ConnectionState.active &&
                            snapshot.hasData) {
                          final listData = snapshot.data?.docs
                              .map((e) => DrinkModel.fromMap(e.data()))
                              .toList();
                          return GridView.builder(
                            padding: const EdgeInsets.all(Sizes.padding),
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 1 / 1.4,
                              crossAxisCount: 2,
                              mainAxisSpacing: Sizes.padding,
                              crossAxisSpacing: Sizes.padding,
                            ),
                            itemCount: listData?.length ?? 0,
                            itemBuilder: (_, index) {
                              final name = listData?[index].name;
                              // final img = listData[index].image;
                              final unitPrice = listData?[index].unitPrice;
                              final qty = listData?[index].amount;

                              return DrinkCard(
                                name: name,
                                image:
                                    'https://cdn.shopify.com/s/files/1/0298/4581/5429/products/ReusableCup_grande.png?v=1578631807',
                                unitPrice: unitPrice,
                                qty: qty,
                              );
                            },
                          );
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
}
