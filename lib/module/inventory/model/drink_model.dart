// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class DrinkModel {
  final String name;
  final String category;
  final num unitPrice;
  final int amount;
  final String? id;
  final DateTime? createdDate;
  DrinkModel({
    required this.name,
    required this.category,
    required this.unitPrice,
    required this.amount,
    this.id,
    this.createdDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'category': category,
      'unitPrice': unitPrice,
      'amount': amount,
      'id': id,
      'createdDate': createdDate,
    };
  }

  factory DrinkModel.fromMap(Map<String, dynamic> map) {
    return DrinkModel(
      name: map['name'] as String,
      category: map['category'] as String,
      unitPrice: map['unitPrice'] as num,
      amount: map['amount'] as int,
      id: map['id'] != null ? map['id'] as String : null,
      createdDate:
          map['createdDate'] is Timestamp ? map['createdDate'].toDate() : null,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory DrinkModel.fromJson(String source) =>
  //     DrinkModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
