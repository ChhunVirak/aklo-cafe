import 'package:aklo_cafe/constant/resources.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String name;
  final Color? backgroundColor;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.name,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.maxFinite, 50),
        backgroundColor: backgroundColor ?? AppColors.secondaryColor,
      ),
      onPressed: onPressed,
      child: Text(
        name,
        style: AppStyle.medium.copyWith(
            color: AppColors.txtLightColor, fontVariations: [Sizes.weightL]),
      ),
    );
  }
}
