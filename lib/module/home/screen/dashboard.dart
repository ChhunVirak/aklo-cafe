import 'package:aklo_cafe/module/home/controller/dashboard_controller.dart';
import 'package:flutter/cupertino.dart';
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
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitDown,
    //   DeviceOrientation.portraitUp,
    // ]);
    Get.toNamed(Routes.CLIENT_ORDER);
    // showCustomModalBottomSheet(
    //   Column(
    //     children: [
    //       Sizes.defaultPadding.sh,
    //       Text(
    //         S.current.scan,
    //         style: AppStyle.large,
    //       ),
    //       Sizes.textPadding.sh,
    //       Expanded(
    //         child: Image.network(
    //           'https://www.bleepstatic.com/images/news/u/1164866/2022/Apr-2022/qr-code-moving/qr-code-moving.gif',
    //         ),
    //       ),
    //     ],
    //   ),
    // );
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
      body: [
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
                    icon: CupertinoIcons.bag_fill,
                    bgColor: const Color(0xffd51c4e),
                  ),
                  MenuCard(
                    onTap: () {
                      _handleNavigate(context, 'Histories');
                    },
                    title: S.current.histories,
                    icon: CupertinoIcons.bag_fill,
                    bgColor: const Color(0xfff56313),
                  ),
                  MenuCard(
                    onTap: () {
                      _handleNavigate(context, 'Inventory');
                    },
                    title: S.current.inventory,
                    icon: CupertinoIcons.bag_fill,
                    bgColor: const Color(0xff1b67ca),
                  ),
                  MenuCard(
                    onTap: () {
                      _handleNavigate(context, 'Users');
                    },
                    title: S.current.users,
                    icon: CupertinoIcons.bag_fill,
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
