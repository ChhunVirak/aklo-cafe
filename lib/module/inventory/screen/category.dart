import 'package:aklo_cafe/config/languages/lang_font_controller.dart';
import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/module/inventory/controller/inventory_controller.dart';
import 'package:aklo_cafe/module/inventory/model/category_model.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/alerts/app_dialog.dart';
import '../../../util/alerts/app_snackbar.dart';
import '../../../util/widgets/app_circular_loading.dart';
import '../../../util/widgets/custom_button.dart';
import '../components/drink_card.dart';

class CategoryScreen extends GetView<InventoryController> {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.category),
      ),
      body: StreamBuilder(
        stream: controller.categoryDb.snapshots(),
        builder: (_, snapshot) {
          debugPrint('Snapshot => ${snapshot.connectionState}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CustomCircularLoading(),
            );
          }
          if (snapshot.hasData) {
            final listData = snapshot.data?.docs
                .map((e) => CategoryModel.fromMap(e.data()))
                .toList();
            return GridView.builder(
              padding: const EdgeInsets.all(Sizes.padding),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1 / 1.3,
                crossAxisCount: 2,
                mainAxisSpacing: Sizes.padding,
                crossAxisSpacing: Sizes.padding,
              ),
              itemCount: listData?.length ?? 0,
              itemBuilder: (_, index) {
                final img = listData?[index].image;

                final name = Get.locale == Langs.english.locale
                    ? (listData?[index].nameEn)
                    : (listData?[index].nameKh);

                return GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      BottomSheet(
                        onClosing: () {},
                        builder: (context) {
                          return Container(
                            padding: const EdgeInsets.all(Sizes.defaultPadding),
                            // color: Colors.white,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomButton(
                                  onPressed: () {
                                    Get.back();

                                    //TODO : initial Data to Edit
                                    // controller
                                    //     .initialDrinkForEdit(
                                    //         listData?[index]);
                                    // Get.toNamed(
                                    //   Routes.EDIT_DRINK,
                                    //   parameters: {'isAdd': '0'},
                                    // );
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
                                          onPressed: () async {
                                            await controller.drinkDb
                                                .doc(listData?[index].id)
                                                .delete();
                                            Get.back();
                                            Get.back();
                                            showErrorSnackBar(
                                                title: 'Success',
                                                description:
                                                    'Delete successfully');
                                          },
                                          child: const Text('Yes'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('No'),
                                        ),
                                      ],
                                    );
                                  },
                                  backgroundColor: Colors.red,
                                  name: 'Delete',
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      isScrollControlled: true,
                    );
                  },
                  child: DrinkCard(
                    name: name,
                    image: img,
                    // unitPrice: 0,
                    // qty: qty,
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text('Something went wrong'),
          );
        },
      ),
    );
  }
}
