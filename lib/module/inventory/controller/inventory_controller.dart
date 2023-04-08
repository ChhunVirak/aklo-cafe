import 'dart:io';

import 'package:aklo_cafe/module/inventory/model/drink_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../util/snackbar/app_snackbar.dart';
import '../../home/model/coffee_model.dart';
import '../model/category_model.dart';

import 'package:path/path.dart' as path;

class InventoryController extends GetxController {
  @override
  void onClose() {
    debugPrint('Success Closed 1');
    super.onClose();
  }

  @override
  void dispose() {
    debugPrint('Success Closed');
    super.dispose();
  }

  //Firebase Collection
  final categoryDb = FirebaseFirestore.instance.collection('category');

  final listInventoryMenu = <DashBoardModel>[
    DashBoardModel(
      title: 'Drink',
      iconData: CupertinoIcons.list_number,
      bgColor: const Color(0xffd51c4e),
    ),
    DashBoardModel(
      title: 'Add',
      iconData: CupertinoIcons.add_circled_solid,
      bgColor: const Color(0xfff56313),
    ),
    DashBoardModel(
      title: 'Category',
      iconData: CupertinoIcons.square_list_fill,
      bgColor: const Color(0xff1b67ca),
    ),
  ];

  ///Category
  final categories = [
    'Ice Coffee',
    'Frappe',
    'Tea',
  ];

  final db = FirebaseFirestore.instance;

  final drinkNameTxTcontroller = TextEditingController();
  final drinkCategoryTxTcontroller = TextEditingController();
  final unitPriceTxTcontroller = TextEditingController();
  final amountTxTcontroller = TextEditingController();

  void clear() {
    drinkNameTxTcontroller.clear();
    drinkCategoryTxTcontroller.clear();
    unitPriceTxTcontroller.clear();
    amountTxTcontroller.clear();
  }

  Future<bool> addDrink() async {
    try {
      final newDrink = DrinkModel(
        name: drinkNameTxTcontroller.text,
        category: drinkCategoryTxTcontroller.text,
        unitPrice: num.tryParse(unitPriceTxTcontroller.text) ?? 0,
        amount: int.tryParse(amountTxTcontroller.text) ?? 0,
        createdDate: DateTime.now(),
      );
      final result = await db.collection('drink').add(
            newDrink.toMap(),
          );
      await db.collection('drink').doc(result.id).update(
        {
          'id': result.id,
        },
      );
      return true;
    } catch (_) {
      debugPrint('Error $_');
      showErrorSnackBar(
        title: 'Error',
        description: 'Drink add fail',
      );
      return false;
    }
    // return null;
  }

  final categoryNameTxtcontroller = TextEditingController();

  void clearFormAddCategory() {
    categoryNameTxtcontroller.clear();
  }

  File? categoryFile;
  Future<bool> addCategory() async {
    try {
      final newCategory = CategoryModel(
        name: categoryNameTxtcontroller.text,
      );

      await uploadFile(categoryFile);

      final result = await categoryDb.add(
        newCategory.toMap(),
      );
      await categoryDb.doc(result.id).update(
        {
          'id': result.id,
        },
      );
      return true;
    } catch (_) {
      debugPrint('Error $_');
      showErrorSnackBar(
        title: 'Error',
        description: 'Drink add fail',
      );
      return false;
    }
    // return null;
  }

  final ref = FirebaseStorage.instance.ref();

  Future<UploadTask?> uploadFile(File? file) async {
    if (file != null) {
      try {
        return ref.child('category/01').putFile(file);
      } catch (_) {
        debugPrint('Upload Fail : $_');
      }
    } else {
      debugPrint('File not found');
    }
    return null;
  }

  Future<void> deleteImage(String folder, String file) async {
    final location = path.join(folder, file);
    try {
      await ref.child(location).delete();
    } catch (_) {
      debugPrint('Delete Fail : $_');
    }
  }
}
