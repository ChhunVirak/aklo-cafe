import 'package:aklo_cafe/module/home/controller/dashboard_controller.dart';
import 'package:aklo_cafe/module/inventory/screen/inventory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/menu_card.dart';

import 'package:aklo_cafe/constant/resources.dart';

class DashBoard extends GetView<DashBoardController> {
  const DashBoard({super.key});

  void _handleNavigate(BuildContext context, String menu) {
    if (context.mounted) {
      switch (menu) {
        case 'Orders':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Inventory(),
            ),
          );
          break;
        case 'Histories':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Inventory(),
            ),
          );
          break;
        case 'Inventory':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Inventory(),
            ),
          );
          break;
        case 'Users':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Inventory(),
            ),
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.3 / 1,
              child: Container(
                // margin: const EdgeInsets.symmetric(
                //   horizontal: Sizes.padding,
                // ),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.lightColor,
                  borderRadius: Sizes.boxRadius,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'Today orders : ',
                        style: AppStyle.medium
                            .copyWith(color: AppColors.txtLightColor),
                        children: [
                          TextSpan(
                            text: '23 Units',
                            style: AppStyle.large
                                .copyWith(color: AppColors.txtLightColor),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'Available Coffee : ',
                        style: AppStyle.medium
                            .copyWith(color: AppColors.txtLightColor),
                        children: [
                          TextSpan(
                            text: '78 units',
                            style: AppStyle.large
                                .copyWith(color: AppColors.txtLightColor),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: Sizes.padding),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: Sizes.padding,
                crossAxisSpacing: Sizes.padding,
              ),
              itemCount: controller.listDashBoard.length,
              itemBuilder: (_, index) {
                final name = controller.listDashBoard[index].title;
                final icon = controller.listDashBoard[index].iconData;
                final bgColor = controller.listDashBoard[index].bgColor;
                return MenuCard(
                  onTap: () {
                    _handleNavigate(context, name);
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
