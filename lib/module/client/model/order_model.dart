import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrderModel {
  final String? id;
  final DateTime orderDate;
  final List<Product> products;
  final num total;
  final String? status;
  OrderModel({
    this.id,
    required this.orderDate,
    required this.products,
    required this.total,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'orderDate': orderDate.millisecondsSinceEpoch,
      'products': products.map((x) => x.toMap()).toList(),
      'total': total,
      'status': status,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] != null ? map['id'] as String : null,
      orderDate: DateTime.fromMillisecondsSinceEpoch(map['orderDate'] as int),
      products: List<Product>.from(
        (map['products']).map<Product>(
          (x) => Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
      total: map['total'] as num,
      status: map['status'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Product {
  String id;
  int amount;
  String name;
  Product({
    required this.id,
    required this.amount,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'name': name,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      amount: map['amount'] as int,
      name: map['name'] as String,
    );
  }
}
