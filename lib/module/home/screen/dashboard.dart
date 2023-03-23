import 'package:aklo_cafe/module/home/controller/dashboard_controller.dart';
import 'package:aklo_cafe/module/inventory/screen/inventory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../components/menu_card.dart';

import 'package:aklo_cafe/constant/resources.dart';

class DashBoard extends GetView<DashBoardController> {
  DashBoard({super.key});

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

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _form.currentState?.validate();
        },
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
            Form(
              key: _form,
              child: TextFormField(
                onChanged: (v) {},
                inputFormatters: [
                  NumberTextInputFormatter(
                      mask: '### ### ### ###', separator: ' '),
                ],
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

class NumberTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  NumberTextInputFormatter({
    required this.mask,
    required this.separator,
  }) {
    // assert(mask != null);
    // assert(separator != null);
  }

  //11111111111

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.length < mask.length &&
            mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text:
                '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      } else {
        debugPrint('Old ${oldValue.selection.end}');
        debugPrint('New ${newValue.selection.end}');
        if (newValue.text.length < mask.length &&
            mask[newValue.selection.end] == separator) {
          // return oldValue.copyWith(text: );
        }
      }
    }
    return newValue;
  }
}
