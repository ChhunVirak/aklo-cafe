import 'dart:io';

import 'package:aklo_cafe/constant/firebase_storage_path.dart';
import 'package:aklo_cafe/core/firebase_core/model/file_model.dart';
import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/inventory/model/drink_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../config/router/app_pages.dart';
import '../../../util/alerts/app_dialog.dart';
import '../../../util/alerts/app_snackbar.dart';
import '../../home/model/coffee_model.dart';
import '../model/category_model.dart';

import 'package:path/path.dart' as path;

class FirebaseHelper {
  static final _ref = FirebaseStorage.instance.ref();

  Future<void> deleteFile(String folder, String file) async {
    final location = path.join(folder, file);
    try {
      await _ref.child(location).delete();
    } catch (_) {
      debugPrint('Delete Fail : $_');
    }
  }
}

class InventoryController extends GetxController {
  //Firebase Collection
  final drinkDb = FirebaseFirestore.instance.collection('drink');

  Stream<QuerySnapshot<Map<String, dynamic>>> drinkofCategory(String c) {
    const field = 'category';
    if (c == 'All' || c == '') {
      return drinkDb.limit(10).snapshots();
    } else {
      return drinkDb.where(field, isEqualTo: c).limit(10).snapshots();
    }
  }

  //Firebase Collection
  final categoryDb = FirebaseFirestore.instance.collection('category');

  final currentCategory = 'All'.obs;

  final listInventoryMenu = <DashBoardModel>[
    DashBoardModel(
      title: 'Drink',
      iconData: CupertinoIcons.list_number,
      bgColor: const Color(0xffd51c4e),
    ),
    DashBoardModel(
      title: 'Add Drink',
      iconData: CupertinoIcons.add_circled_solid,
      bgColor: const Color(0xfff56313),
    ),
    DashBoardModel(
      title: 'Category',
      iconData: CupertinoIcons.square_list_fill,
      bgColor: const Color(0xff1b67ca),
    ),
    DashBoardModel(
      title: S.current.addCategory,
      iconData: CupertinoIcons.square_list_fill,
      bgColor: const Color(0xfff56313),
    ),
  ];

  final db = FirebaseFirestore.instance;

  final drinkNameTxTcontroller = TextEditingController();
  final drinkCategoryTxTcontroller = TextEditingController();
  final unitPriceTxTcontroller = TextEditingController();
  final amountTxTcontroller = TextEditingController();

  void clearFormAddProduct() {
    drinkNameTxTcontroller.clear();
    drinkCategoryTxTcontroller.clear();
    unitPriceTxTcontroller.clear();
    amountTxTcontroller.clear();
  }

  void initialDrinkForEdit(DrinkModel? drinkModel) {
    if (drinkModel != null) {
      drinkNameTxTcontroller.text = drinkModel.name;
      drinkCategoryTxTcontroller.text = drinkModel.category;
      unitPriceTxTcontroller.text = drinkModel.unitPrice.toString();
      amountTxTcontroller.text = drinkModel.amount.toString();
    }
  }

  Future<void> addDrink() async {
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
      Get.until((route) => Get.currentRoute == Routes.INVENTORY);
      showSuccessSnackBar(
        title: 'Success',
        description: 'New drink has been added successfully.',
      );
    } catch (_) {
      debugPrint('Error $_');
      showErrorSnackBar(
        title: 'Error',
        description: 'Drink add fail',
      );
    }
    // return null;
  }

  Future<void> updateDrink(String? id) async {
    if (id != null) {
      try {
        final newDrink = DrinkModel(
          name: drinkNameTxTcontroller.text,
          category: drinkCategoryTxTcontroller.text,
          unitPrice: num.tryParse(unitPriceTxTcontroller.text) ?? 0,
          amount: int.tryParse(amountTxTcontroller.text) ?? 0,
          createdDate: DateTime.now(),
        ).toMap()
          ..removeWhere(
            (key, value) => value == null,
          );

        await db.collection('drink').doc(id).update(
              newDrink,
            );
        debugPrint('Current Route ${Get.currentRoute}');
        debugPrint('Current Route 2 ${Routes.ALL_DRINK}');

        Get.until((route) {
          debugPrint('Route : ${route.runtimeType}');
          GetPageRoute<dynamic> r = route;
          return true;
        });
        showSuccessSnackBar(
          title: S.current.success,
          description: 'New drink has been update successfully.',
        );
      } catch (_) {
        debugPrint('Error $_');
        showErrorSnackBar(
          title: 'Error',
          description: 'Drink add fail $_',
        );
      }
    }
  }

  final categoryEnglishNameTxtcontroller = TextEditingController();
  final categoryKhmerNameTxtcontroller = TextEditingController();
  final categoryDescriptionTxtcontroller = TextEditingController();

  void clearFormAddCategory() {
    categoryEnglishNameTxtcontroller.clear();
    categoryKhmerNameTxtcontroller.clear();
    categoryDescriptionTxtcontroller.clear();
  }

  File? categoryFile;
  Future addCategory() async {
    showLoadingDialog();

    try {
      final newCategory = CategoryModel(
        nameEn: categoryEnglishNameTxtcontroller.text,
        nameKh: categoryKhmerNameTxtcontroller.text,
      );

      final result = await categoryDb.add(newCategory.toMap());

      final imageUrl = await uploadFile(result.id, categoryFile);

      await categoryDb.doc(result.id).update(
        {
          'id': result.id,
          'image': imageUrl,
          'firebaseFile': FirebaseStorageFileModel(
                  folder: FireBaseStoragePath.category, fileName: result.id)
              .toMap()
        },
      );
      clearFormAddCategory();
      Get.until((route) => Get.currentRoute == Routes.INVENTORY);

      showSuccessSnackBar(
        title: 'Success',
        description: 'New Category has been added successfully.',
      );
    } catch (_) {
      debugPrint('Error $_');
      showErrorSnackBar(
        title: 'Error',
        description: 'Drink add fail',
      );
    }
    // return null;
  }

  final ref = FirebaseStorage.instance.ref();

  Future<String?> uploadFile(String id, File? file) async {
    if (file != null) {
      try {
        final upload = await ref
            .child('${FireBaseStoragePath.category}/$id')
            .putFile(file);
        return await upload.ref.getDownloadURL();
      } catch (_) {
        debugPrint('Upload Fail : $_');
      }
    } else {
      debugPrint('File not found');
    }
    return null;
  }

  Future<void> deleteFile(String folder, String file) async {
    final location = path.join(folder, file);
    try {
      await ref.child(location).delete();
    } catch (_) {
      debugPrint('Delete Fail : $_');
    }
  }
}
