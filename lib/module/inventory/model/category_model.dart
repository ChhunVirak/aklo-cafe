// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:aklo_cafe/core/firebase_core/model/file_model.dart';

class CategoryModel {
  final String? id;
  final String nameEn;
  final String nameKh;
  final String? image;
  final FirebaseStorageFileModel? firebaseFile;
  CategoryModel({
    this.id,
    this.nameEn = '',
    this.nameKh = '',
    this.image,
    this.firebaseFile,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nameEn': nameEn,
      'nameKh': nameKh,
      'image': image,
      'firebaseFile': firebaseFile?.toMap(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] != null ? map['id'] as String : null,
      nameEn: map['nameEn'] != null ? map['nameEn'] as String : '',
      nameKh: map['nameKh'] != null ? map['nameKh'] as String : '',
      image: map['image'] != null ? map['image'] as String : null,
      firebaseFile: map['firebaseFile'] != null
          ? FirebaseStorageFileModel.fromMap(
              map['firebaseFile'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
