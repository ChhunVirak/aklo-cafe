import 'package:flutter/material.dart';

extension AppWidget on num {
  Widget get sw => SizedBox(width: toDouble());
  Widget get sh => SizedBox(height: toDouble());
}

extension TxtStyle on BuildContext {
  TextStyle get h1 => Theme.of(this).textTheme.headlineLarge!;
}
