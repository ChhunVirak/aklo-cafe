import 'package:flutter/material.dart';

class DashBoardModel {
  final String title;
  final IconData iconData;
  final Color bgColor;
  DashBoardModel({
    required this.title,
    required this.iconData,
    this.bgColor = Colors.transparent,
  });
}
