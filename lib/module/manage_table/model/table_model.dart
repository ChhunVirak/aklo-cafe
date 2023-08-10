import 'dart:convert';

class TableModel {
  final String? id;
  final String? currentOrderId;

  final int number;

  TableModel({
    this.id,
    this.currentOrderId,
    required this.number,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'currentOrderId': currentOrderId,
      'number': number,
    };
  }

  factory TableModel.fromMap(Map<String, dynamic> map) {
    return TableModel(
      id: map['id'] != null ? map['id'] as String : null,
      currentOrderId: map['currentOrderId'] != null
          ? map['currentOrderId'] as String
          : null,
      number: map['number'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TableModel.fromJson(String source) =>
      TableModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
