import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminOrderController extends GetxController {
  final _allordersDb = FirebaseFirestore.instance.collection('orders');

  final today = DateTime.now();

  allOrderToday() => _allordersDb
      .where('order_date', isGreaterThanOrEqualTo: today)
      .snapshots();
}
