import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';

import 'package:aklo_cafe/constant/resources.dart';

class MenuCard extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Color? bgColor;
  final GestureTapCallback? onTap;
  const MenuCard({
    super.key,
    required this.title,
    required this.icon,
    this.bgColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: Sizes.boxBorderRadius,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            // color: Colors.white,
            color: bgColor,
            boxShadow: const [
              AppStyle.boxShadow,
            ],
          ),
          // clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Icon(
                  icon,
                  color: AppColors.txtLightColor,
                  size: 50,
                ),
              ),
              5.sh,
              Text(
                title ?? '',
                style: AppStyle.medium.copyWith(color: AppColors.txtLightColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
