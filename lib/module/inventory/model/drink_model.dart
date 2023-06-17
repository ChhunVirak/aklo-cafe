import 'dart:convert';

class DrinkModel {
  final String name;
  final String categoryId;
  final num unitPrice;
  final String? id;
  final DateTime? createdDate;
  DrinkModel({
    required this.name,
    required this.categoryId,
    required this.unitPrice,
    this.id,
    this.createdDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'categoryId': categoryId,
      'unitPrice': unitPrice,
      'id': id,
      'createdDate': createdDate?.millisecondsSinceEpoch,
    };
  }

  factory DrinkModel.fromMap(Map<String, dynamic> map) {
    return DrinkModel(
      name: map['name'] as String,
      categoryId: map['categoryId'] as String,
      unitPrice: map['unitPrice'] as num,
      id: map['id'] != null ? map['id'] as String : null,
      createdDate: map['createdDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdDate'] as int)
          : null,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory DrinkModel.fromJson(String source) =>
  //     DrinkModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory DrinkModel.fromJson(String source) =>
      DrinkModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
