import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              'assets/client/making_coffee.json',
              width: context.width * 0.8,
            ),
            10.sh,
            Text(
              'Please wait drink is making!',
              style: AppStyle.large,
            )
          ],
        ),
      ),
    );
  }
}
