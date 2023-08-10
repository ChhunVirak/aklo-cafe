import 'package:aklo_cafe/config/menu/dashboard_config.dart';
import 'package:aklo_cafe/module/home/controller/dashboard_controller.dart';
import 'package:aklo_cafe/module/manage_table/screen/screen_manage_table.dart';
import 'package:aklo_cafe/module/order/controller/admin_order_controller.dart';
import 'package:aklo_cafe/module/order_data/screen/order_data_screen.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

import '../../../config/router/app_pages.dart';
import '../../../generated/l10n.dart';
import '../../../util/alerts/app_modal_bottomsheet.dart';
import '../../../util/alerts/app_snackbar.dart';
import '../../auth/controller/auth_controller.dart';
import '../components/image_slider.dart';
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
    const eMenuLink = 'https://aklo-cafe.web.app/';
    showCustomModalBottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Sizes.defaultPadding.sh,
          Text(
            S.current.scan,
            style: AppStyle.large,
          ),
          Sizes.textPadding.sh,
          Padding(
            padding: const EdgeInsets.all(Sizes.defaultPadding),
            child: Image.network(
              'https://api.qrserver.com/v1/create-qr-code/?size=1000x1000&data=$eMenuLink',
            ),
          ),
        ],
      ),
    );
  }

  int _currentIndex = 0;

  final authController = Get.put(AuthController());
  final controller = Get.put(DashBoardController());
  final adminOrderController = Get.put(AdminOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showQrWebSite(context);
          // Get.to(() => ClientOrderScreen());
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
        SingleChildScrollView(
          child: Column(
            children: [
              ImageSlider(),
              20.sh,
              // Container(
              //   width: double.infinity,
              //   margin:
              //       const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 0),
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //   decoration: BoxDecoration(
              //     color: Colors.green,
              //     borderRadius: Sizes.boxBorderRadius,
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       StreamBuilder(
              //         stream: adminOrderController.totalOrder,
              //         builder: (_, snapshot) {
              //           if (snapshot.hasData) {
              //             return Text.rich(
              //               TextSpan(
              //                 text: '${S.current.today_Total_Order} : ',
              //                 style: AppStyle.medium
              //                     .copyWith(color: AppColors.txtLightColor),
              //                 children: [
              //                   TextSpan(
              //                     text: snapshot.data,
              //                     style: AppStyle.large
              //                         .copyWith(color: AppColors.txtLightColor),
              //                   ),
              //                 ],
              //               ),
              //             );
              //           }
              //           return SizedBox.shrink();
              //         },
              //       )
              //     ],
              //   ),
              // ),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                  left: Sizes.defaultPadding,
                  right: Sizes.defaultPadding,
                  bottom: Sizes.padding + 20,
                  top: Sizes.textPadding,
                ),
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
                      pushSubRoute(Routes.ORDERS);
                    },
                    title: S.current.orders,
                    icon: PhosphorIcons.list_numbers_fill,
                    imagePath: DashBoardConfig.orders,
                    bgColor: const Color(0xffd51c4e),
                  ),
                  MenuCard(
                    onTap: () {
                      Get.to(() => OrderDataScreen());
                    },
                    title: S.current.data,
                    icon: PhosphorIcons.hard_drive_bold,
                    bgColor: Color(0xFF7F1CD5),
                  ),
                  MenuCard(
                    onTap: () {
                      _handleNavigate(context, 'Inventory');
                    },
                    title: S.current.inventory,
                    icon: PhosphorIcons.database_fill,
                    // imagePath: DashBoardConfig.inventory,
                    bgColor: const Color(0xff1b67ca),
                  ),
                  MenuCard(
                    onTap: () {
                      if (authController.isAdmin.value) {
                        _handleNavigate(context, 'Users');
                      } else {
                        showErrorSnackBar(
                            title: "No Permission", description: '....');
                      }
                    },
                    title: S.current.users,
                    icon: PhosphorIcons.users_three_fill,
                    bgColor: const Color(0xff257881),
                  ),
                  MenuCard(
                    onTap: () {
                      pushSubRoute(Routes.ABOUT_US);
                    },
                    title: S.current.about_us,
                    icon: PhosphorIcons.user_square_bold,
                    bgColor: const Color(0xfff56313),
                  ),
                  MenuCard(
                    onTap: () {
                      if (authController.isAdmin.value) {
                        Get.to(() => ScreenManageTable());
                      } else {
                        showErrorSnackBar(
                            title: "No Permission", description: '....');
                      }
                    },
                    title: S.current.manageTable,
                    icon: PhosphorIcons.storefront_bold,
                    bgColor: Color(0xFF00BAA5),
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
