import 'package:flutter/material.dart';

import '../../constant/resources.dart';

class CustomListtile extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;
  final String? subtitle;
  final TileIcon? leading;
  final TextStyle? textStyle;
  final Widget? trailing;
  const CustomListtile({
    super.key,
    required this.title,
    this.onTap,
    this.subtitle,
    this.leading,
    this.textStyle,
    this.trailing,
  });

  Widget? get leadingIcon => leading != null
      ? leading?.icon != null
          ? Icon(
              leading?.icon,
            )
          : SizedBox(
              height: double.maxFinite,
              child: leading?.widget,
            )
      : null;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingIcon,
      trailing: trailing,
      title: Text(
        title,
        style: textStyle ?? AppStyle.large,
      ),
      subtitle: Text(subtitle ?? ''),
      onTap: () {
        onTap?.call();
        // _logOut(context);
      },
    );
  }
}

class TileIcon {
  IconData? icon;
  Widget? widget;

  TileIcon.widget(this.widget);
  TileIcon.iconData(this.icon);
}
