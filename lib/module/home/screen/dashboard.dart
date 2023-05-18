import 'package:aklo_cafe/module/home/controller/dashboard_controller.dart';
import 'package:aklo_cafe/util/alerts/app_modal_bottomsheet.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/router/app_pages.dart';
import '../../../generated/l10n.dart';
import '../../../util/alerts/app_snackbar.dart';
import '../../auth/controller/auth_controller.dart';
import '../../auth/screen/users_screen.dart';
import '../../order/screen/orders_screen.dart';
import '../components/menu_card.dart';

import 'package:aklo_cafe/constant/resources.dart';

import 'setting_screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
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
          Get.toNamed(Routes.INVENTORY);
          break;
        case 'Users':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UsersScreen(),
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

  void _showQrWebSite(BuildContext context) {
    showCustomModalBottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Sizes.defaultPadding.sh,
          Text(
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

  int _currentIndex = 0;

  final authController = Get.put(AuthController());
  final controller = Get.put(DashBoardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showQrWebSite(context);
        },
        child: const Icon(
          Icons.qr_code_rounded,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        elevation: 0,
        backgroundColor: Colors.transparent,
        fixedColor: Colors.black,
        onTap: (value) {
          if (_currentIndex != value) {
            setState(() {
              _currentIndex = value;
            });
          }

          // authController.signOut();
          // if (value == 1) {
          // showErrorSnackBar(
          //   title: 'Oppps',
          //   description: 'Sorry this feature is not available yet.',
          // );
          // }
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.dashboard,
            ),
            label: S.current.dashboard,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.settings,
            ),
            label: S.current.setting,
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text(Strings.appName),
      ),
      body: DefaultTabController(
        length: 2,
        child: [
          SingleChildScrollView(
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
                      borderRadius: Sizes.boxBorderRadius,
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
          const SettingScreen()
        ].elementAt(_currentIndex),
      ),
    );
  }
}
