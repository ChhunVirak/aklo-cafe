import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminOrderController extends GetxController {
  final _allordersDb = FirebaseFirestore.instance.collection('orders');

  final now = DateTime.now();

  get today => DateTime(now.year, now.month, now.day);

  Stream<DocumentSnapshot<Map<String, dynamic>>> orderDataOfId(String? id) =>
      _allordersDb.doc(id).snapshots();

  Stream<String> get totalOrder => _allordersDb
      .where(
        'orderDate',
        isGreaterThanOrEqualTo: Timestamp.fromDate(
          today,
        ),
      )
      .snapshots()
      .map((event) => event.docs.length.toString());

  ///ALl Order
  Stream<QuerySnapshot<Map<String, dynamic>>> get allOrderToday => _allordersDb
      .orderBy('orderDate', descending: true)
      // .where(
      //   'orderDate',
      //   isGreaterThanOrEqualTo: Timestamp.fromDate(
      //     today,
      //   ),
      // )
      .snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> orderOf(String status) =>
      _allordersDb
          .where('status', isEqualTo: status)
          // .where(
          //   'orderDate',
          //   isEqualTo: Timestamp.fromDate(today),
          // )
          .snapshots();

  Future<void> onClickAccept(String? id) async {
    if (id == null) return;
    await _allordersDb.doc(id).update(
      {
        'status': Status.confirm,
      },
    );
  }

  Future<void> onClickCancel(String? id) async {
    debugPrint('Works $id');
    if (id == null) return;
    await _allordersDb.doc(id).update(
      {
        'status': Status.cancel,
      },
    );
  }

  Future<void> onClickConfirm(String? id) async {
    debugPrint('Works $id');
    if (id == null) return;
    await _allordersDb.doc(id).update(
      {
        'status': Status.done,
      },
    );
  }
}

class Status {
  static const neworder = 'NEW';
  static const confirm = 'CONFIRM';
  static const cancel = 'CANCEL';
  static const done = 'DONE';
  static const finish = 'FINISH';
}

extension Coloors on Status {
  Color? get c {
    if (this == Status.neworder) return Colors.teal;
    if (this == Status.cancel) return Colors.red;
    if (this == Status.confirm) return Colors.orange;
    if (this == Status.done) return Colors.green;
    return null;
  }
}
