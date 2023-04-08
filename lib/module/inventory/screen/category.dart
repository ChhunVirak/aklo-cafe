import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/module/inventory/controller/inventory_controller.dart';
import 'package:aklo_cafe/module/inventory/model/category_model.dart';
import 'package:aklo_cafe/module/inventory/screen/add_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.hasData) {
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
                final name = listData?[index].name;
                // final img = listData[index].image;

                return DrinkCard(
                  name: name,
                  image:
                      'https://firebasestorage.googleapis.com/v0/b/aklo-cafe.appspot.com/o/category?alt=media&token=0cc4c904-3f5f-4b2a-8c4e-60e0b774f1fa',
                  unitPrice: 0,
                  // qty: qty,
                );
              },
            );
          }
          return const Center(
            child: Text('Something went wrong'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        onPressed: () {
          controller.clearFormAddCategory();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddCategory(),
            ),
          );
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
