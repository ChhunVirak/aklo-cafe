import 'package:flutter/material.dart';

class RealButton extends StatelessWidget {
  final Widget child;
  final GestureTapCallback? onTap;
  final BoxDecoration? decoration;
  const RealButton({
    super.key,
    required this.child,
    this.onTap,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      borderRadius: decoration?.borderRadius as BorderRadius,
      child: Ink(
        decoration: decoration,
        child: child,
      ),
    );
  }
}
