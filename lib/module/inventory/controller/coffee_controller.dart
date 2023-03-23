import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../home/model/coffee_model.dart';

class InventoryController extends GetxController {
  final listInventoryMenu = <DashBoardModel>[
    DashBoardModel(
      title: 'Coffee',
      iconData: CupertinoIcons.list_number,
      bgColor: const Color(0xffd51c4e),
    ),
    DashBoardModel(
      title: 'Add',
      iconData: CupertinoIcons.add_circled_solid,
      bgColor: const Color(0xfff56313),
    ),
    DashBoardModel(
      title: 'Update',
      iconData: CupertinoIcons.upload_circle_fill,
      bgColor: const Color(0xff1b67ca),
    ),
    DashBoardModel(
      title: 'Delete',
      iconData: CupertinoIcons.delete_solid,
      bgColor: const Color(0xff257881),
    )
  ];
}
