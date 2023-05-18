import 'package:aklo_cafe/constant/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(
          value: 0.5,
          backgroundColor: AppColors.mainColor,
        ),
      ),
    );
  }
}
