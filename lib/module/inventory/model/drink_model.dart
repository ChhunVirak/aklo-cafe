// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class DrinkModel {
  final String name;
  final String categoryId;
  final num unitPrice;
  final String? id;
  final Timestamp? createdDate;
  final bool? available;
  final String? image;
  DrinkModel({
    required this.name,
    required this.categoryId,
    required this.unitPrice,
    this.id,
    this.createdDate,
    this.available,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'categoryId': categoryId,
      'unitPrice': unitPrice,
      'id': id,
      'createdDate': createdDate,
      'available': available,
      'image': image,
    };
  }

  factory DrinkModel.fromMap(Map<String, dynamic> map) {
    return DrinkModel(
      name: map['name'] as String,
      categoryId: map['categoryId'] as String,
      unitPrice: map['unitPrice'] as num,
      id: map['id'] != null ? map['id'] as String : null,
      createdDate: map['createdDate'] != null ? map['createdDate'] : null,
      available: map['available'] != null ? map['available'] as bool : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory DrinkModel.fromJson(String source) =>
  //     DrinkModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory DrinkModel.fromJson(String source) =>
      DrinkModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
