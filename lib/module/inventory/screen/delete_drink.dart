import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/module/inventory/controller/inventory_controller.dart';
import 'package:aklo_cafe/module/inventory/model/drink_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/drink_card.dart';

class DeleteDrinkScreen extends GetView<InventoryController> {
  const DeleteDrinkScreen({super.key});

  void _showDeleteDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (popContext) => AlertDialog(
        actionsPadding: const EdgeInsets.only(
          right: Sizes.defaultPadding,
          bottom: Sizes.tablePadding,
        ),
        titlePadding: const EdgeInsets.only(
          top: Sizes.defaultPadding,
          left: Sizes.defaultPadding,
          bottom: Sizes.tablePadding,
        ),
        contentPadding: const EdgeInsets.only(
          left: Sizes.defaultPadding,
          right: Sizes.defaultPadding,
        ),
        surfaceTintColor: AppColors.txtLightColor,
        backgroundColor: AppColors.txtLightColor,
        titleTextStyle: AppStyle.large,
        contentTextStyle: AppStyle.medium.copyWith(
          fontWeight: FontWeight.w400,
        ),
        // contentPadding: EdgeInsets.zero,
        title: const Text('Warning'),
        content: const Text('Do you want to delete this Drink?'),
        actions: [
          TextButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('drink')
                  .doc(id)
                  .delete();
              if (popContext.mounted) {
                Navigator.pop(popContext);
              }
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(popContext);
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.allCoffeeTitle),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('drink').snapshots(),
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
                .map((e) => DrinkModel.fromMap(e.data()))
                .toList();
            return GridView.builder(
              padding: const EdgeInsets.all(Sizes.padding),
              shrinkWrap: true,
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
                final unitPrice = listData?[index].unitPrice;
                final qty = listData?[index].amount;
                final id = listData?[index].id;

                return GestureDetector(
                  onTap: () {
                    _showDeleteDialog(context, id!);
                  },
                  child: DrinkCard(
                    name: name,
                    image:
                        'https://cdn.shopify.com/s/files/1/0298/4581/5429/products/ReusableCup_grande.png?v=1578631807',
                    unitPrice: unitPrice,
                    qty: qty,
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
