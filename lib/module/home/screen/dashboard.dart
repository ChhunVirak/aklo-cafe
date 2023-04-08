import 'package:aklo_cafe/module/home/controller/dashboard_controller.dart';
import 'package:aklo_cafe/module/inventory/screen/inventory_screen.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/snackbar/app_snackbar.dart';
import '../../order/screen/orders_screen.dart';
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
              builder: (context) => const OrderScreen(),
            ),
          );
          break;
        // case 'Histories':
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const Inventory(),
        //     ),
        //   );
        //   break;
        case 'Inventory':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Inventory(),
            ),
          );
          break;
        // case 'Users':
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const Inventory(),
        //     ),
        //   );
        //   break;
        default:
          showErrorSnackBar(
            title: 'Oppps',
            description: 'Sorry this feature is not available yet.',
          );
      }
    }
  }

  void _showQrWebSite(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (_) => Column(
        children: [
          Sizes.defaultPadding.sh,
          const Text(
            'Scan to order',
            style: AppStyle.large,
          ),
          Sizes.textPadding.sh,
          Center(
            child: Image.network(
              'https://hosttools.com/wp-content/uploads/QR-Code-.png.webp',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showQrWebSite(context);
        },
        backgroundColor: AppColors.mainColor,
        child: const Icon(
          Icons.qr_code_rounded,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        fixedColor: Colors.black,
        onTap: (value) {
          if (value == 1) {
            showErrorSnackBar(
              title: 'Oppps',
              description: 'Sorry this feature is not available yet.',
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Setting',
          ),
        ],
      ),
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
                  color: const Color.fromARGB(255, 6, 114, 9),
                  borderRadius: Sizes.boxRadius,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text.rich(
                        TextSpan(
                          text: 'Today orders : ',
                          style: AppStyle.medium
                              .copyWith(color: AppColors.txtLightColor),
                          children: [
                            TextSpan(
                              text: controller.totalSold.value.toString(),
                              style: AppStyle.large
                                  .copyWith(color: AppColors.txtLightColor),
                            ),
                          ],
                        ),
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
