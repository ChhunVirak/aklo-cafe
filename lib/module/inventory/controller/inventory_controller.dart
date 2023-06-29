import 'dart:io';

import 'package:aklo_cafe/config/languages/lang_font_controller.dart';
import 'package:aklo_cafe/constant/firebase_storage_path.dart';
import 'package:aklo_cafe/core/firebase_core/model/file_model.dart';
import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/inventory/model/drink_model.dart';
import 'package:aklo_cafe/util/extensions/object_validation_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../config/router/app_pages.dart';
import '../../../util/alerts/app_dialog.dart';
import '../../../util/alerts/app_snackbar.dart';
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
    const field = 'categoryId';
    debugPrint('statement $c');
    if (c == 'All') {
      return drinkDb.snapshots();
    } else {
      return drinkDb.where(field, isEqualTo: c).snapshots();
    }
  }

  //Firebase Collection
  final categoryDb = FirebaseFirestore.instance.collection('category');
  Future<bool> deleteCategory(CategoryModel? categoryModel) async {
    if (categoryModel == null) return false; //End
    if (categoryModel.id != null) {}
    await categoryDb.doc(categoryModel.id).delete();
    if (categoryModel.image.isValid) {
      await deleteFile(url: categoryModel.image);
    }
    return true;
  }

  final currentCategory = 'All'.obs;
  final currentCategoryID = ''.obs;

  final db = FirebaseFirestore.instance;

  String? displayImage;
  final drinkNameTxTcontroller = TextEditingController();
  final drinkCategoryTxTcontroller = TextEditingController();
  final unitPriceTxTcontroller = TextEditingController();
  // final amountTxTcontroller = TextEditingController();

  void clearFormAddProduct() {
    drinkNameTxTcontroller.clear();
    drinkCategoryTxTcontroller.clear();
    unitPriceTxTcontroller.clear();
    // amountTxTcontroller.clear();
  }

  void clearDisplayImage() {
    displayImage = null;
  }

  final initialLoading = false.obs;
  void initialDrinkForEdit(String? id) async {
    if (id == null) return;
    //start loading
    initialLoading(true);
    try {
      //Get data
      final data = await drinkDb.doc(id).get().then((value) => value.data());

      if (data == null) {
        initialLoading(false);
        return;
      }

      DrinkModel drinkModel = DrinkModel.fromMap(data);

      final category = await categoryDb
          .doc(drinkModel.categoryId)
          .get()
          .then((value) => value.data());

      CategoryModel categoryModel = CategoryModel.fromMap(category ?? {});
      if (drinkModel.image != null && drinkModel.image!.isNotEmpty) {
        displayImage = drinkModel.image;
      }
      selectedCategoryID = categoryModel.id;
      drinkNameTxTcontroller.text = drinkModel.name;
      drinkCategoryTxTcontroller.text = Get.locale == Langs.english.locale
          ? categoryModel.nameEn
          : categoryModel.nameKh;

      unitPriceTxTcontroller.text = drinkModel.unitPrice.toString();
      available.value = drinkModel.available ?? true;
    } catch (e) {
      if (e is FirebaseException) debugPrint('Error ${e.message}');
    } finally {
      initialLoading(false);
    }
  }

  String? selectedCategoryID;
  final RxBool available = true.obs;

  Future<void> addDrink(String? imagePath) async {
    if (selectedCategoryID == null) return;
    showLoadingDialog();
    try {
      final newDrink = DrinkModel(
        name: drinkNameTxTcontroller.text,
        categoryId: selectedCategoryID!,
        unitPrice: num.tryParse(unitPriceTxTcontroller.text) ?? 0,
        available: available.value,
        createdDate: Timestamp.fromDate(DateTime.now()),
      );

      //remove item no value avoid change value on database
      newDrink.toMap().removeWhere((_, value) => value == null);
      final result = await db.collection('drink').add(
            newDrink.toMap(),
          );
      await db.collection('drink').doc(result.id).update(
        {
          'id': result.id,
        },
      );

      ///Upload Image
      if (imagePath != null) {
        String? getDownloadURL = await uploadFile(
            type: FireBaseStoragePath.drink,
            id: result.id,
            file: File(imagePath));

        await db.collection('drink').doc(result.id).update(
          {
            'image': getDownloadURL,
          },
        );
      }

      ///
      adminRouter.go(Routes.INVENTORY);

      showSuccessSnackBar(
        title: 'Success',
        description: 'New drink has been added successfully.',
      );
    } catch (_) {
      debugPrint('Error $_');
      removeDialog();
      showErrorSnackBar(
        title: 'Error',
        description: 'Drink add fail',
      );
    }
    // return null;
  }

  Future<void> updateDrink(String? id, String? imagePath) async {
    if (selectedCategoryID == null) {
      showErrorSnackBar(
        title: 'No Category found',
        description: 'Please select category',
      );
      return; //end func
    }

    if (id != null) {
      showLoadingDialog();

      ///Upload Image
      String? downloadLink;

      if (imagePath.isValid) {
        downloadLink = await uploadFile(
            id: id, type: FireBaseStoragePath.drink, file: File(imagePath!));
      }
      try {
        final newDrink = DrinkModel(
                name: drinkNameTxTcontroller.text,
                categoryId: selectedCategoryID!,
                unitPrice: num.tryParse(unitPriceTxTcontroller.text) ?? 0,
                createdDate: Timestamp.fromDate(DateTime.now()),
                available: available.value,
                image: downloadLink)
            .toMap()
          ..removeWhere(
            (key, value) => value == null,
          );

        await db.collection('drink').doc(id).update(
              newDrink,
            );
        debugPrint('Current Route ${Get.currentRoute}');
        debugPrint('Current Route 2 ${Routes.ALL_DRINK}');
        Get.back();

        adminRouter.go(Routes.ALL_DRINK_FULL);
        showSuccessSnackBar(
          title: S.current.success,
          description: 'New drink has been update successfully.',
        );
      } catch (_) {
        debugPrint('Error $_');
        removeDialog();
        showErrorSnackBar(
          title: 'Error',
          description: 'Drink add fail $_',
        );
      }
    }
  }

  Future<void> deleteDrink(String? id, String? imageUrl) async {
    if (id == null) return;

    await drinkDb.doc(id).delete();
    await deleteFile(url: imageUrl);
  }

  final categoryEnglishNameTxtcontroller = TextEditingController();
  final categoryKhmerNameTxtcontroller = TextEditingController();
  // final categoryDescriptionTxtcontroller = TextEditingController();

  void clearFormAddCategory() {
    categoryEnglishNameTxtcontroller.clear();
    categoryKhmerNameTxtcontroller.clear();
    // categoryDescriptionTxtcontroller.clear();
  }

  final initialCategoryFormLoading = false.obs;
  String? tempCategoryImage;
  void initialCategoryForm(String? id) async {
    debugPrint('Category ID = ${id}');
    if (id == null) return;
    initialCategoryFormLoading(true);

    try {
      final data = await categoryDb.doc(id).get().then((value) => value.data());
      if (data == null) return;

      CategoryModel categoryModel = CategoryModel.fromMap(data);
      categoryEnglishNameTxtcontroller.text = categoryModel.nameEn;
      categoryKhmerNameTxtcontroller.text = categoryModel.nameKh;
      if (categoryModel.image != null && categoryModel.image!.isNotEmpty) {
        tempCategoryImage = categoryModel.image;
      }
    } catch (e) {
      debugPrint('Category Error $e');
      if (e is FirebaseException) debugPrint('Category Error ${e.message}');
    } finally {
      initialCategoryFormLoading(false);
    }
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

      final imageUrl = await uploadFile(
          type: FireBaseStoragePath.category,
          id: result.id,
          file: categoryFile);

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
      adminRouter.go(Routes.INVENTORY);

      showSuccessSnackBar(
        title: S.current.success,
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

  Future<void> updateCategory(String? id) async {
    if (id == null) return;
    showLoadingDialog();
    String? getDownloadURL;
    if (categoryFile != null) {
      getDownloadURL = await uploadFile(
          id: id, type: FireBaseStoragePath.category, file: categoryFile);
    }

    try {
      Map<String, dynamic> data = CategoryModel(
        nameEn: categoryEnglishNameTxtcontroller.text,
        nameKh: categoryKhmerNameTxtcontroller.text,
        image: getDownloadURL,
      ).toMap();
      data.removeWhere((key, value) => value == null);
      await categoryDb.doc(id).update(data);
      removeDialog();
      adminRouter.go(Routes.CATEGORY_FULL);
      showSuccessSnackBar(
          title: S.current.success, description: S.current.update);
    } catch (e) {
      removeDialog();
      showErrorSnackBar(title: 'Fail', description: 'Update Fail');
    }
  }

  final ref = FirebaseStorage.instance.ref();

  Future<bool> deleteFile({required String? url}) async {
    if (url == null || url.isEmpty) return false;
    try {
      await FirebaseStorage.instance.refFromURL(url).delete();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<String?> uploadFile(
      {required String id, required String type, required File? file}) async {
    if (file != null) {
      try {
        final upload = await ref.child('${type}/$id').putFile(file);

        return await upload.ref.getDownloadURL();
      } catch (_) {
        debugPrint('Upload Fail : $_');
      }
    } else {
      debugPrint('File not found');
    }
    return null;
  }
}
