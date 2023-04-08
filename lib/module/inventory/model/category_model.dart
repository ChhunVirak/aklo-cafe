// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:aklo_cafe/core/firebase_core/model/file_model.dart';

class CategoryModel {
  final String? id;
  final String name;
  final FirebaseStorageFileModel? firebaseFile;
  CategoryModel({
    this.firebaseFile,
    this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'firebaseFile': firebaseFile?.toMap(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
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
