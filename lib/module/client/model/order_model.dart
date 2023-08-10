import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? id;
  final int? tableNumber;

  final DateTime orderDate;
  final List<Product> products;
  final num total;
  final String? status;
  final String? sugar;
  final String? comment;
  OrderModel({
    this.id,
    this.tableNumber,
    required this.orderDate,
    required this.products,
    required this.total,
    required this.status,
    this.sugar,
    this.comment,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'orderDate': Timestamp.fromDate(orderDate),
      // 'orderDate': Timestamp.fromDate(orderDate),
      'products': products.map((x) => x.toMap()).toList(),
      'total': total,
      'status': status,
      'sugar': sugar,
      'comment': comment,
      'tableNumber': tableNumber,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] != null ? map['id'] as String : null,
      tableNumber:
          map['tableNumber'] != null ? map['tableNumber'] as int : null,
      orderDate: (map['orderDate'] as Timestamp).toDate(),
      // orderDate: (map['orderDate'] as Timestamp).toDate(),
      products: List<Product>.from(
        (map['products']).map<Product>(
          (x) => Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
      total: map['total'] as num,
      status: map['status'] != null ? map['status'] as String : null,
      sugar: map['sugar'] != null ? map['sugar'] as String : null,
      comment: map['comment'] != null ? map['comment'] as String : null,
    );
  }
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
