import 'package:aklo_cafe/module/home/model/coffee_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  final totalSold = 0.obs;
  final s = DashBoardModel(
    title: 'Users',
    iconData: CupertinoIcons.person_2_fill,
    bgColor: const Color(0xff257881),
  ).obs;
  final db = FirebaseFirestore.instance.collection('data');

  @override
  void onReady() {
    // debugPrint('Ready');
    // Stream<int>? a =
    //     db.doc('y7KJKGeMDPzUA63yiHO9').snapshots().map<int>((event) {
    //   Map<String, dynamic>? data = event.data();
    //   return data?['total'];
    // });
    // totalSold.bindStream(a);
    // totalSold.reactive;

    super.onReady();
  }
}
