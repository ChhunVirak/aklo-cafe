import 'package:aklo_cafe/module/home/controller/dashboard_controller.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

import '../../../config/router/app_pages.dart';
import '../../../generated/l10n.dart';
import '../../../util/alerts/app_modal_bottomsheet.dart';
import '../../../util/alerts/app_snackbar.dart';
import '../../auth/controller/auth_controller.dart';
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
          pushSubRoute('inventory');
          break;
        case 'Users':
          pushSubRoute(Routes.USER);
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
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitDown,
    //   DeviceOrientation.portraitUp,
    // ]);
    // Get.toNamed(Routes.CLIENT_ORDER);
    showCustomModalBottomSheet(
      Column(
        children: [
          Sizes.defaultPadding.sh,
          Text(
            S.current.scan,
            style: AppStyle.large,
          ),
          Sizes.textPadding.sh,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(Sizes.defaultPadding),
              child: Image.network(
                'https://api.qrserver.com/v1/create-qr-code/?size=1000x1000&data=http://www.google.com/',
              ),
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
          PhosphorIcons.qr_code_bold,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
              PhosphorIcons.house_line_fill,
            ),
            label: S.current.dashboard,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              PhosphorIcons.gear_six_fill,
            ),
            label: S.current.setting,
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text(Strings.appName),
      ),
      body: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                // aspectRatio: 1.3 / 1,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: Sizes.boxBorderRadius,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Text.rich(
                          TextSpan(
                            text: 'Today or ders : ',
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
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: Sizes.padding),
                // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //   crossAxisCount: 2,
                mainAxisSpacing: Sizes.padding,
                crossAxisSpacing: Sizes.padding,
                // ),
                crossAxisCount: 2,
                // itemCount: controller.listDashBoard.length,
                children: [
                  MenuCard(
                    onTap: () {
                      _handleNavigate(context, 'Orders');
                    },
                    title: S.current.orders,
                    icon: PhosphorIcons.list_numbers_fill,
                    bgColor: const Color(0xffd51c4e),
                  ),
                  MenuCard(
                    onTap: () {
                      _handleNavigate(context, 'Histories');
                    },
                    title: S.current.histories,
                    icon: PhosphorIcons.chart_bar_fill,
                    bgColor: const Color(0xfff56313),
                  ),
                  MenuCard(
                    onTap: () {
                      _handleNavigate(context, 'Inventory');
                    },
                    title: S.current.inventory,
                    icon: PhosphorIcons.database_fill,
                    bgColor: const Color(0xff1b67ca),
                  ),
                  MenuCard(
                    onTap: () {
                      _handleNavigate(context, 'Users');
                    },
                    title: S.current.users,
                    icon: PhosphorIcons.users_three_fill,
                    bgColor: const Color(0xff257881),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SettingScreen()
      ].elementAt(_currentIndex),
    );
  }
}
