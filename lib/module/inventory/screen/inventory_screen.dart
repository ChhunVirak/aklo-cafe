import 'package:aklo_cafe/module/inventory/inventory.dart';
import 'package:aklo_cafe/module/inventory/screen/add_category.dart';
import 'package:aklo_cafe/module/inventory/screen/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/resources.dart';
import '../../../util/alerts/app_snackbar.dart';
import '../../home/components/menu_card.dart';

class Inventory extends GetView<InventoryController> {
  const Inventory({super.key});
  void _handleNavigate(BuildContext context, int index) {
    if (context.mounted) {
      switch (index) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AllCoffeeScreen(),
            ),
          );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddDrinkScreen(),
            ),
          );
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CategoryScreen(),
            ),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddCategory(),
            ),
          );
          break;
        default:
          showErrorSnackBar(
            title: 'Oppps',
            description: 'Sorry this feature is not available yet.',
          );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.inventory,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.padding),
        child: Column(
          children: [
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: Sizes.padding),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: Sizes.padding,
                crossAxisSpacing: Sizes.padding,
              ),
              itemCount: controller.listInventoryMenu.length,
              itemBuilder: (_, index) {
                final name = controller.listInventoryMenu[index].title;
                final icon = controller.listInventoryMenu[index].iconData;
                final bgColor = controller.listInventoryMenu[index].bgColor;
                return MenuCard(
                  onTap: () {
                    _handleNavigate(context, index);
                  },
                  title: name,
                  icon: icon,
                  bgColor: bgColor,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
