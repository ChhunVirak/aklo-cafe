import 'package:aklo_cafe/config/languages/lang_font_controller.dart';
import 'package:aklo_cafe/config/router/app_pages.dart';
import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/inventory/controller/inventory_controller.dart';
import 'package:aklo_cafe/module/inventory/model/category_model.dart';
import 'package:aklo_cafe/util/alerts/app_modal_bottomsheet.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/alerts/app_dialog.dart';
import '../../../util/alerts/app_snackbar.dart';
import '../../../util/widgets/app_circular_loading.dart';
import '../../../util/widgets/custom_button.dart';
import '../../auth/controller/auth_controller.dart';
import '../../auth/controller/user_setting_controller.dart';
import '../components/drink_card.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InventoryController());
    final authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.category),
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
            if (listData == null || listData.isEmpty) {
              return Center(
                child: Text(S.current.no_data),
              );
            }
            return GridView.builder(
              padding: const EdgeInsets.all(Sizes.padding),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1 / 1.2,
                crossAxisCount: 2,
                mainAxisSpacing: Sizes.padding,
                crossAxisSpacing: Sizes.padding,
              ),
              itemCount: listData.length,
              itemBuilder: (_, index) {
                final img = listData[index].image;

                final name = Get.locale == Langs.english.locale
                    ? (listData[index].nameEn)
                    : (listData[index].nameKh);

                final id = listData[index].id;

                return GestureDetector(
                  onTap: () {
                    showCustomModalBottomSheet(
                      Container(
                        padding: const EdgeInsets.all(Sizes.defaultPadding),
                        // color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomButton(
                              onPressed: () {
                                if (authController.userModel?.updateCategory ==
                                    true) {
                                  Get.back();

                                  debugPrint('ID: $id');

                                  pushSubRoute(
                                    Routes.ADD_CATEGORY,
                                    queryParams: {'id': id},
                                  );
                                } else {
                                  showNoPermission();
                                }
                              },
                              name: 'Edit',
                            ),
                            Sizes.defaultPadding.sh,
                            CustomButton(
                              onPressed: () {
                                if (authController.userModel?.deleteCategory ==
                                    true) {
                                  showCustomDialog(
                                    title: S.current.confirm,
                                    description:
                                        'Are you sure want to delete $name',
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          await controller.categoryDb
                                              .doc(listData[index].id)
                                              .delete();

                                          await controller
                                              .deleteCategory(listData[index]);
                                          Get.back();
                                          Get.back();
                                          showErrorSnackBar(
                                              title: 'Success',
                                              description:
                                                  'Delete successfully');
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
                                } else {
                                  showNoPermission();
                                }
                              },
                              backgroundColor: Colors.red,
                              name: 'Delete',
                            ),
                          ],
                        ),
                      ),
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
