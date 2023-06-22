import 'dart:convert';

import 'package:aklo_cafe/module/inventory/inventory.dart';

class ClientOrderModel {
  int unit;
  final DateTime? orderDate;
  final DrinkModel? drinkModel;
  ClientOrderModel({
    this.unit = 0,
    this.orderDate,
    this.drinkModel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'unit': unit,
      'orderDate': orderDate?.millisecondsSinceEpoch,
      'drinkModel': drinkModel?.toMap(),
    };
  }

  factory ClientOrderModel.fromMap(Map<String, dynamic> map) {
    return ClientOrderModel(
      unit: map['unit'] as int,
      orderDate: map['orderDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['orderDate'] as int)
          : null,
      drinkModel: map['drinkModel'] != null
          ? DrinkModel.fromMap(map['drinkModel'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientOrderModel.fromJson(String source) =>
      ClientOrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
