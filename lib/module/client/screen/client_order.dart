import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/client/controller/client_order_controller.dart';
import 'package:aklo_cafe/module/client/screen/check_out_screen.dart';
import 'package:aklo_cafe/util/alerts/app_modal_bottomsheet.dart';
import 'package:aklo_cafe/util/alerts/app_snackbar.dart';
import 'package:aklo_cafe/util/extensions/responsive/responsive_extension.dart';
import 'package:aklo_cafe/util/function/format_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

import '../../../config/languages/lang_font_controller.dart';
import '../../../util/widgets/app_circular_loading.dart';
import '../../inventory/components/drink_card.dart';
import '../../inventory/inventory.dart';
import '../../inventory/model/category_model.dart';

class ClientOrderScreen extends StatefulWidget {
  const ClientOrderScreen({super.key});

  @override
  State<ClientOrderScreen> createState() => _ClientOrderScreenState();
}

class _ClientOrderScreenState extends State<ClientOrderScreen> {
  final controller = Get.put(ClientOrderController());

  final _inventoryController = Get.put(InventoryController());

  Color _chipBgColor(bool selected) =>
      selected ? AppColors.secondaryColor : AppColors.deepBackgroundColor;
  SliverGridDelegate _deligate(BuildContext context) =>
      SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1 / 1.4,
        crossAxisCount: context.responsive<int>(2, sm: 2, md: 3, lg: 4, xl: 5),
        mainAxisSpacing: Sizes.padding,
        crossAxisSpacing: Sizes.padding,
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/logo/aklo-cafe-logo.png',
                      width: 30,
                    ),
                    Text('Aklo Cafe'),
                  ],
                ),
                Switch(
                  value: false,
                  onChanged: (value) {},
                  activeThumbImage:
                      AssetImage('assets/logo/aklo-cafe-logo.png'),
                  inactiveThumbImage:
                      AssetImage('assets/logo/aklo-cafe-logo.png'),
                )
              ],
            ),
          ),
          Expanded(
            child: GetBuilder(
                init: Get.put(InventoryController()),
                initState: (_) {
                  _inventoryController.currentCategory.value = 'All';
                  _inventoryController.currentCategoryID.value = 'All';
                },
                builder: (_) {
                  return Column(
                    children: [
                      ///Tabar
                      StreamBuilder(
                        stream: _inventoryController.categoryDb.snapshots(),
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                                              _inventoryController
                                                      .currentCategory.value ==
                                                  'All'),
                                          labelStyle: AppStyle.small.copyWith(
                                              color: _inventoryController
                                                          .currentCategory
                                                          .value ==
                                                      'All'
                                                  ? AppColors.txtLightColor
                                                  : null),
                                          onPressed: () {
                                            _inventoryController
                                                .currentCategory.value = 'All';
                                            _inventoryController
                                                .currentCategoryID
                                                .value = 'All';
                                          },
                                          label: Text(S.current.all),
                                          shape: const StadiumBorder(),
                                        ),
                                      ),
                                      ...listData
                                              ?.map(
                                                (e) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: Sizes
                                                              .textPadding),
                                                  child: ActionChip(
                                                    backgroundColor: _chipBgColor(
                                                        _inventoryController
                                                                .currentCategory
                                                                .value ==
                                                            e.nameEn),
                                                    onPressed: () {
                                                      _inventoryController
                                                          .currentCategory
                                                          .value = e.nameEn;
                                                      if (e.id == null)
                                                        return; //ends
                                                      _inventoryController
                                                          .currentCategoryID
                                                          .value = e.id ?? '';
                                                    },
                                                    label: Text(Get.locale ==
                                                            Langs.english.locale
                                                        ? e.nameEn
                                                        : e.nameKh),
                                                    labelStyle: AppStyle.small.copyWith(
                                                        color: _inventoryController
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
                            stream: _inventoryController.drinkofCategory(
                                _inventoryController.currentCategoryID.value),
                            builder: (_, snapshot) {
                              debugPrint(
                                  'Snapshot => ${snapshot.connectionState}');
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              debugPrint('Error ${snapshot.hasData}');
                              if (!snapshot.hasData) {
                                return Center(
                                  child: Text(S.current.no_data),
                                );
                              }

                              if (snapshot.hasData) {
                                final listData = snapshot.data?.docs
                                    .map((e) => DrinkModel.fromMap(e.data()))
                                    .toList();
                                if (listData == null || listData.isEmpty) {
                                  return Center(
                                    child: Text(S.current.no_data),
                                  );
                                }
                                return GetBuilder(
                                    init: controller,
                                    builder: (_) {
                                      return GridView.builder(
                                        padding:
                                            const EdgeInsets.all(Sizes.padding),
                                        physics: const BouncingScrollPhysics(),
                                        gridDelegate: _deligate(context),
                                        itemCount: listData.length,
                                        itemBuilder: (_, index) {
                                          final name = listData[index].name;
                                          // final img = listData[index].image;
                                          final unitPrice =
                                              listData[index].unitPrice;

                                          final id = listData[index].id;
                                          final available =
                                              listData[index].available;
                                          debugPrint(available.toString());

                                          return GestureDetector(
                                            onTap: () {
                                              if (GetPlatform.isWeb &&
                                                  available == true) {
                                                showCustomModalBottomSheet(
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .txtLightColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft: Radius
                                                            .circular(Sizes
                                                                .defaultPadding),
                                                        topRight: Radius
                                                            .circular(Sizes
                                                                .defaultPadding),
                                                      ),
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
                                              available: available,
                                              amount: controller.getAmount(id),
                                              onPressedAdd: GetPlatform.isWeb
                                                  ? () {
                                                      controller.addItem(
                                                          listData[index]);
                                                    }
                                                  : null,
                                              onPressedRemove: GetPlatform.isWeb
                                                  ? () {
                                                      controller.removeItem(
                                                          listData[index]);
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
          ),
          Container(
            padding: const EdgeInsets.all(20),
            // height: context.height * 0.2,
            decoration:
                const BoxDecoration(color: AppColors.deepBackgroundColor),
            child: Row(
              children: [
                Obx(
                  () => Expanded(
                    child: Text(
                      'Total ${formatCurrency(controller.total)}\$',
                      style: AppStyle.medium,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (controller.total <= 0) {
                      showErrorSnackBar(
                          title: S.current.add_drink_message,
                          description: S.current.add_drink_message_des);
                      return;
                    }
                    Get.to(const CheckOutScreen());
                  },
                  icon: const Icon(PhosphorIcons.shopping_cart),
                  label: const Text('Check Out'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
