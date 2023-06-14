import 'package:aklo_cafe/config/router/app_pages.dart';
import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/inventory/inventory.dart';
import 'package:aklo_cafe/module/inventory/screen/add_category.dart';
import 'package:aklo_cafe/module/inventory/screen/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
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
          controller.clearFormAddProduct();
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
          controller.clearFormAddCategory();
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
              _handleNavigate(context, 0);
            },
            title: S.current.allCoffeeTitle,
            icon: PhosphorIcons.list_bold,
            bgColor: Colors.blue,
          ),
          MenuCard(
            onTap: () {
              Get.toNamed(Routes.EDIT_DRINK);
            },
            title: S.current.addDrink,
            icon: PhosphorIcons.list_plus_bold,
            bgColor: Colors.green,
          ),
          MenuCard(
            onTap: () {
              _handleNavigate(context, 2);
            },
            title: S.current.category,
            icon: PhosphorIcons.list_bold,
            bgColor: Colors.deepPurple,
          ),
          MenuCard(
            onTap: () {
              _handleNavigate(context, 3);
            },
            title: S.current.addCategory,
            icon: PhosphorIcons.list_plus_bold,
            bgColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget w() => const Text('hello');
}
