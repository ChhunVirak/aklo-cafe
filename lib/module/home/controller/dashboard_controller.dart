import 'package:aklo_cafe/module/home/model/coffee_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController {
  final listDashBoard = <DashBoardModel>[
    DashBoardModel(
      title: 'Orders',
      iconData: CupertinoIcons.list_number,
      bgColor: const Color(0xffd51c4e),
    ),
    DashBoardModel(
      title: 'Histories',
      iconData: CupertinoIcons.chart_bar_alt_fill,
      bgColor: const Color(0xfff56313),
    ),
    DashBoardModel(
      title: 'Inventory',
      iconData: CupertinoIcons.bag_fill,
      bgColor: const Color(0xff1b67ca),
    ),
    DashBoardModel(
      title: 'Users',
      iconData: CupertinoIcons.person_2_fill,
      bgColor: const Color(0xff257881),
    )
  ];
}
