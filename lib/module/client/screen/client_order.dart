import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/client/controller/client_order_controller.dart';
import 'package:aklo_cafe/module/client/model/order_model.dart';
import 'package:aklo_cafe/module/client/screen/order_status.dart';
import 'package:aklo_cafe/module/home/components/image_slider.dart';
import 'package:aklo_cafe/module/manage_table/model/table_model.dart';
import 'package:aklo_cafe/module/order/controller/admin_order_controller.dart';
import 'package:aklo_cafe/util/extensions/responsive/responsive_extension.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../config/languages/lang_font_controller.dart';
import '../../../util/widgets/app_circular_loading.dart';
import '../../inventory/components/client_drink_card.dart';
import '../../inventory/inventory.dart';
import '../../inventory/model/category_model.dart';
import '../widgets/order_infor_and_checkout_button.dart';
import 'check_out_screen.dart';

class ClientOrderScreen extends StatefulWidget {
  final String? tableId;
  const ClientOrderScreen({
    super.key,
    this.tableId,
  });

  @override
  State<ClientOrderScreen> createState() => _ClientOrderScreenState();
}

class _ClientOrderScreenState extends State<ClientOrderScreen> {
  final controller = Get.put(ClientOrderController());
  final languageController = Get.put(LangsAndFontConfigs());

  final _inventoryController = Get.put(InventoryController());

  Color _chipBgColor(bool selected) =>
      selected ? AppColors.secondaryColor : AppColors.deepBackgroundColor;
  SliverGridDelegate _deligate(BuildContext context) =>
      SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1 / 1.36,
        crossAxisCount: context.responsive<int>(2, sm: 2, md: 3, lg: 4, xl: 5),
        mainAxisSpacing: Sizes.padding,
        crossAxisSpacing: Sizes.padding,
      );
  double value = 0;

  Future<TableModel?> get getTable async => await FirebaseFirestore.instance
      .collection('tables')
      .doc(widget.tableId)
      .get()
      .then(
        (value) =>
            value.data() != null ? TableModel.fromMap(value.data()!) : null,
      );

  @override
  void initState() {
    print('Table Id ${widget.tableId}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return

        ///TODO: Switch Screen
        GetBuilder(
      id: 'Current Order',
      init: controller,
      builder: (_) {
        return StreamBuilder(
          stream: controller.currentOrder,
          builder: (_, snapshot) {
            final data = snapshot.data?.data();
            if (snapshot.hasData &&
                data != null &&
                controller.cureentOrderId.isNotEmpty) {
              final orderModel = OrderModel.fromMap(data);
              debugPrint(
                  'HAS 11 ${controller.cureentOrderId} ${orderModel.status}');
              switch (orderModel.status) {
                case Status.neworder:
                case Status.confirm:
                case Status.cancel:
                case Status.done:
                  controller.screen(Screen.status);
                  controller.showback(false);
                  break;

                default:
                  controller.screen(Screen.order);
                  controller.showback(true);
                  break;
              }
            } else {
              debugPrint('DATA null');
              controller.screen(Screen.order);
              controller.showback(true);
            }
            return GetBuilder(
              id: 'Screen',
              init: controller,
              builder: (_) => controller.screen.value == Screen.checkout
                  ? CheckOutScreen(tableId: widget.tableId)
                  : controller.screen.value == Screen.status
                      ? OrderStatus()
                      : Scaffold(
                          body: NestedScrollView(
                            headerSliverBuilder:
                                (context, innerBoxIsScrolled) => [
                              SliverAppBar(
                                // backgroundColor: Colors.w,
                                automaticallyImplyLeading: false,
                                toolbarHeight: 90,
                                elevation: 0,
                                title: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            'assets/logo/aklo-cafe-logo.png',
                                        width: 40,
                                      ),
                                      10.sw,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            Strings.appName,
                                            style: AppStyle.medium,
                                          ),
                                          FutureBuilder(
                                            future: getTable,
                                            builder: (_, snapshot) {
                                              final data = snapshot.data;
                                              if (snapshot.hasData &&
                                                  data != null) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Text(
                                                    'Table No: ${NumberFormat('00', 'en').format(data.number)}',
                                                    style: AppStyle.medium,
                                                  ),
                                                );
                                              }
                                              return SizedBox.shrink();
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      languageController.chooseLangauge();
                                    },
                                    icon: Icon(PhosphorIcons.translate),
                                    label: Text(
                                      languageController.isEnglish
                                          ? "En"
                                          : 'ខ្មែរ',
                                    ),
                                  ),
                                  10.sw,
                                ],
                              ),
                              SliverAppBar(
                                automaticallyImplyLeading: false,
                                expandedHeight: 250,
                                flexibleSpace: FlexibleSpaceBar(
                                  background: ImageSlider(),
                                ),
                                elevation: 0,
                              )
                            ],
                            body: Stack(
                              children: [
                                Column(
                                  children: [
                                    // ImageSlider(),
                                    Expanded(
                                      child: GetBuilder(
                                        id: 'Drink Display',
                                        init: _inventoryController,
                                        initState: (_) {
                                          _inventoryController
                                              .currentCategory.value = 'All';
                                          _inventoryController
                                              .currentCategoryID.value = 'All';
                                        },
                                        builder: (_) {
                                          return Column(
                                            children: [
                                              ///Tabar
                                              StreamBuilder(
                                                stream: _inventoryController
                                                    .categoryDb
                                                    .snapshots(),
                                                builder: (_, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const Center(
                                                        child:
                                                            CustomCircularLoading());
                                                  }
                                                  if (snapshot.hasData) {
                                                    final listData =
                                                        snapshot.data?.docs
                                                            .map(
                                                              (e) =>
                                                                  CategoryModel
                                                                      .fromMap(
                                                                e.data(),
                                                              ),
                                                            )
                                                            .toList();
                                                    return Obx(
                                                      () => SizedBox(
                                                        width: context.width,
                                                        child:
                                                            SingleChildScrollView(
                                                          padding: const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: Sizes
                                                                  .defaultPadding,
                                                              vertical: Sizes
                                                                  .tablePadding),
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .only(
                                                                    right: Sizes
                                                                        .textPadding),
                                                                child:
                                                                    ActionChip(
                                                                  backgroundColor:
                                                                      _chipBgColor(_inventoryController
                                                                              .currentCategory
                                                                              .value ==
                                                                          'All'),
                                                                  labelStyle: AppStyle.small.copyWith(
                                                                      color: _inventoryController.currentCategory.value ==
                                                                              'All'
                                                                          ? AppColors
                                                                              .txtLightColor
                                                                          : null),
                                                                  onPressed:
                                                                      () {
                                                                    debugPrint(
                                                                        'Pressed');
                                                                    if (_inventoryController
                                                                            .currentCategory
                                                                            .value !=
                                                                        'All') {
                                                                      _inventoryController
                                                                          .currentCategory
                                                                          .value = 'All';
                                                                      _inventoryController
                                                                          .currentCategoryID
                                                                          .value = 'All';
                                                                      _inventoryController
                                                                          .update([
                                                                        'All Drinks'
                                                                      ]);
                                                                    }
                                                                  },
                                                                  label: Text(S
                                                                      .current
                                                                      .all),
                                                                  shape:
                                                                      const StadiumBorder(),
                                                                ),
                                                              ),
                                                              ...listData
                                                                      ?.map(
                                                                        (e) =>
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(right: Sizes.textPadding),
                                                                          child:
                                                                              ActionChip(
                                                                            backgroundColor:
                                                                                _chipBgColor(_inventoryController.currentCategory.value == e.nameEn),
                                                                            onPressed:
                                                                                () {
                                                                              if (_inventoryController.currentCategory.value == e.nameEn)
                                                                                return;
                                                                              _inventoryController.currentCategory.value = e.nameEn;
                                                                              if (e.id == null)
                                                                                return; //ends
                                                                              _inventoryController.currentCategoryID.value = e.id ?? '';
                                                                              _inventoryController.update([
                                                                                'All Drinks'
                                                                              ]);
                                                                            },
                                                                            label: Text(Get.locale == Langs.english.locale
                                                                                ? e.nameEn
                                                                                : e.nameKh),
                                                                            labelStyle:
                                                                                AppStyle.small.copyWith(color: _inventoryController.currentCategory.value == e.nameEn ? AppColors.txtLightColor : null),
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
                                                  return const SizedBox
                                                      .shrink();
                                                },
                                              ),

                                              ///All Drink
                                              Expanded(
                                                child: GetBuilder(
                                                  id: 'All Drinks',
                                                  init: _inventoryController,
                                                  builder: (_) {
                                                    return StreamBuilder(
                                                      stream: _inventoryController
                                                          .drinkofCategory(
                                                              _inventoryController
                                                                  .currentCategoryID
                                                                  .value),
                                                      builder: (_, snapshot) {
                                                        debugPrint(
                                                            'Snapshot => ${snapshot.connectionState}');
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                        }
                                                        debugPrint(
                                                            'Error ${snapshot.hasData}');
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                            child: Text(S
                                                                .current
                                                                .no_data),
                                                          );
                                                        }

                                                        if (snapshot.hasData) {
                                                          final listData = snapshot
                                                              .data?.docs
                                                              .map((e) =>
                                                                  DrinkModel
                                                                      .fromMap(e
                                                                          .data()))
                                                              .toList();
                                                          if (listData ==
                                                                  null ||
                                                              listData
                                                                  .isEmpty) {
                                                            return Center(
                                                              child: Text(S
                                                                  .current
                                                                  .no_data),
                                                            );
                                                          }
                                                          return GetBuilder(
                                                              id: 'Drinks',
                                                              init: controller,
                                                              builder: (_) {
                                                                return GridView
                                                                    .builder(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    top: Sizes
                                                                        .padding,
                                                                    left: Sizes
                                                                        .padding,
                                                                    right: Sizes
                                                                        .padding,
                                                                    bottom: 90,
                                                                  ),
                                                                  physics:
                                                                      const BouncingScrollPhysics(),
                                                                  gridDelegate:
                                                                      _deligate(
                                                                          context),
                                                                  itemCount:
                                                                      listData
                                                                          .length,
                                                                  itemBuilder:
                                                                      (_, index) {
                                                                    final name =
                                                                        listData[index]
                                                                            .name;
                                                                    final image =
                                                                        listData[index]
                                                                            .image;
                                                                    // final img = listData[index].image;
                                                                    final unitPrice =
                                                                        listData[index]
                                                                            .unitPrice;

                                                                    final id =
                                                                        listData[index]
                                                                            .id;
                                                                    final available =
                                                                        listData[index]
                                                                            .available;
                                                                    debugPrint(
                                                                        available
                                                                            .toString());

                                                                    return GestureDetector(
                                                                      // onTap:
                                                                      //     () {
                                                                      //   if (GetPlatform.isWeb &&
                                                                      //       available ==
                                                                      //           true) {
                                                                      //     int unit =
                                                                      //         0;
                                                                      //     showCustomModalBottomSheetNoLimit(
                                                                      //       StatefulBuilder(
                                                                      //         builder: (context, state) {
                                                                      //           return Container(
                                                                      //             padding: EdgeInsets.all(Sizes.defaultPadding),
                                                                      //             decoration: BoxDecoration(
                                                                      //               color: AppColors.txtLightColor,
                                                                      //               borderRadius: BorderRadius.only(
                                                                      //                 topLeft: Radius.circular(Sizes.defaultPadding),
                                                                      //                 topRight: Radius.circular(Sizes.defaultPadding),
                                                                      //               ),
                                                                      //             ),
                                                                      //             child: Column(
                                                                      //               mainAxisSize: MainAxisSize.min,
                                                                      //               crossAxisAlignment: CrossAxisAlignment.start,
                                                                      //               children: [
                                                                      //                 Text(
                                                                      //                   name,
                                                                      //                   style: AppStyle.medium,
                                                                      //                 ),
                                                                      //                 5.sh,
                                                                      //                 Text(
                                                                      //                   '\$' + NumberFormat('#.00', 'en').format(unitPrice),
                                                                      //                   style: AppStyle.medium,
                                                                      //                 ),
                                                                      //                 10.sh,
                                                                      //                 Text(S.current.sugar + ' ${(value * 100).toInt()}%'),
                                                                      //                 Slider(
                                                                      //                   value: value,
                                                                      //                   onChanged: (v) {
                                                                      //                     state(() {
                                                                      //                       value = v;
                                                                      //                     });
                                                                      //                   },
                                                                      //                   divisions: 10,
                                                                      //                   activeColor: AppColors.mainColor,
                                                                      //                   label: (value * 100).toInt().toString() + '%',
                                                                      //                 ),
                                                                      //                 Row(
                                                                      //                   mainAxisAlignment: MainAxisAlignment.center,
                                                                      //                   children: [
                                                                      //                     IconButton(
                                                                      //                       onPressed: () {},
                                                                      //                       icon: Icon(
                                                                      //                         PhosphorIcons.minus_circle,
                                                                      //                       ),
                                                                      //                     ),
                                                                      //                     Text(
                                                                      //                       '$unit',
                                                                      //                       style: AppStyle.large,
                                                                      //                     ),
                                                                      //                     IconButton(
                                                                      //                       onPressed: () {
                                                                      //                         state(() {
                                                                      //                           unit++;
                                                                      //                         });
                                                                      //                       },
                                                                      //                       icon: Icon(
                                                                      //                         PhosphorIcons.plus_circle,
                                                                      //                       ),
                                                                      //                     ),
                                                                      //                     Expanded(
                                                                      //                       child: CustomButton(
                                                                      //                         onPressed: () {},
                                                                      //                         name: 'Add to cart',
                                                                      //                       ),
                                                                      //                     )
                                                                      //                   ],
                                                                      //                 ),
                                                                      //               ],
                                                                      //             ),
                                                                      //           );
                                                                      //         },
                                                                      //       ),
                                                                      //     );
                                                                      //   }
                                                                      // },
                                                                      child:
                                                                          ClientDrinkCard(
                                                                        name:
                                                                            name,
                                                                        image:
                                                                            image,
                                                                        unitPrice:
                                                                            unitPrice,
                                                                        available:
                                                                            available,
                                                                        amount:
                                                                            controller.getAmount(id),
                                                                        onPressedAdd: GetPlatform.isWeb &&
                                                                                available == true
                                                                            ? () {
                                                                                controller.addItem(listData[index]);
                                                                              }
                                                                            : null,
                                                                        onPressedRemove: GetPlatform.isWeb &&
                                                                                available == true
                                                                            ? () {
                                                                                controller.removeItem(listData[index]);
                                                                              }
                                                                            : null,
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              });
                                                        }

                                                        return const Center(
                                                          child: Text(
                                                              'Something went wrong'),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 20,
                                  child: GetBuilder(
                                    id: 'Total',
                                    init: controller,
                                    builder: (_) {
                                      return OrderInfoAndCheckOut();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
            );
          },
        );
      },
    );
  }
}
