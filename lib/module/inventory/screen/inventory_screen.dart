import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/inventory/inventory.dart';
import 'package:aklo_cafe/module/inventory/screen/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

import '../../../config/router/app_pages.dart';
import '../../../constant/resources.dart';
import '../../../util/alerts/app_snackbar.dart';
import '../../home/components/menu_card.dart';

class Inventory extends StatelessWidget {
  const Inventory({super.key});
  void _handleNavigate(BuildContext context, int index) {
    if (context.mounted) {
      switch (index) {
        case 0:
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
    final controller = Get.put(InventoryController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.inventory,
        ),
      ),
      body: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        // shrinkWrap: true,
        padding: const EdgeInsets.all(Sizes.padding),
        crossAxisCount: 2,
        mainAxisSpacing: Sizes.padding,
        crossAxisSpacing: Sizes.padding,
        children: [
          MenuCard(
            onTap: () {
              pushSubRoute(Routes.ALL_DRINK);
            },
            title: S.current.allCoffeeTitle,
            icon: PhosphorIcons.list_bold,
            bgColor: Colors.blue,
          ),
          MenuCard(
            onTap: () {
              controller.clearFormAddProduct();
              pushSubRoute(Routes.EDIT_DRINK);
            },
            title: S.current.addDrink,
            icon: PhosphorIcons.list_plus_bold,
            bgColor: Colors.green,
          ),
          MenuCard(
            onTap: () {
              pushSubRoute(Routes.CATEGORY);
            },
            title: S.current.category,
            icon: PhosphorIcons.list_bold,
            bgColor: Colors.deepPurple,
          ),
          MenuCard(
            onTap: () {
              controller.clearFormAddCategory();
              pushSubRoute(Routes.ADD_CATEGORY);
            },
            title: S.current.addCategory,
            icon: PhosphorIcons.list_plus_bold,
            bgColor: Colors.teal,
          ),
          MenuCard(
            onTap: () {},
            title: 'Clear Drink',
            icon: PhosphorIcons.list_plus_bold,
            bgColor: Colors.red,
          ),
          MenuCard(
            onTap: () {},
            title: 'Clear Category',
            icon: PhosphorIcons.list_plus_bold,
            bgColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
