import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/resources.dart';
import '../../home/components/menu_card.dart';
import '../controller/coffee_controller.dart';

class Inventory extends GetView<InventoryController> {
  const Inventory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                    // _handleNavigate(context, name);
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
