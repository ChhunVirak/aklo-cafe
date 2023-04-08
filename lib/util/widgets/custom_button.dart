import 'package:aklo_cafe/constant/resources.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final String name;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.maxFinite, 50),
        backgroundColor: AppColors.secondaryColor,
      ),
      onPressed: onPressed,
      child: Text(
        name,
        style: AppStyle.large.copyWith(
          color: AppColors.txtLightColor,
        ),
      ),
    );
  }
}
