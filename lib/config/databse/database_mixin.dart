import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static final _db = FirebaseFirestore.instance;

  final categoryDb = _db.collection('category');
  final drinkDb = _db.collection('drink');
}
