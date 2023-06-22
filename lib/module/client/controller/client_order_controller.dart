import 'package:aklo_cafe/module/order/controller/admin_order_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../inventory/model/drink_model.dart';
import '../model/client_order_model.dart';
import '../model/order_model.dart';

const CLIENT_ORDERS = 'client-order-data';

class ClientOrderController extends GetxController {
  late SharedPreferences _pref;

  @override
  void onInit() async {
    _pref = await SharedPreferences.getInstance();
    await getLocalData();
    super.onInit();
  }

  Future<void> getLocalData() async {
    final localData = await _pref.getStringList(CLIENT_ORDERS) ?? [];
    debugPrint('Local Storage : $localData');
  }

  Future<void> storeLocal(Map<String, ClientOrderModel> data) async {
    await _pref.setStringList(
      CLIENT_ORDERS,
      [],
    );
  }

  final _listOrder = <String, ClientOrderModel>{}.obs;

  Map<String, ClientOrderModel> get getList => _listOrder;

  int? getAmount(String? id) =>
      _listOrder.containsKey(id) ? _listOrder[id]!.unit : null;

  void addItem(DrinkModel? drink) {
    if (drink == null) return;
    final id = drink.id;
    if (id == null) return;
    if (_listOrder.containsKey(drink.id)) {
      _listOrder[id]!.unit = _listOrder[id]!.unit + 1;
      _listOrder.refresh();
    } else {
      _listOrder.addAll(
        {
          id: ClientOrderModel(unit: 1, drinkModel: drink),
        },
      );
    }
    update();
    storeLocal(_listOrder);
  }

  void removeItem(DrinkModel? drink) {
    if (drink == null) return;
    final id = drink.id;
    if (id == null) return;
    if (_listOrder[id]?.unit == 0) return; //
    if (_listOrder.containsKey(drink.id)) {
      _listOrder[id]!.unit = _listOrder[id]!.unit - 1;
      if (_listOrder[id]!.unit <= 0) {
        _listOrder.remove(id);
      }
      _listOrder.refresh();
    }
    update();
    storeLocal(_listOrder);
  }

  num get total => _listOrder.isNotEmpty
      ? _listOrder.entries
          .map<num>((e) => e.value.unit * (e.value.drinkModel?.unitPrice ?? 0))
          .reduce((a, b) => a + b)
      : 0;

  final _allordersDb = FirebaseFirestore.instance.collection('orders');

  Future<String> submitOrder() async {
    final listSelectedDrink = _listOrder.entries
        .map(
          (e) => Product(
            id: e.key,
            amount: e.value.unit,
            name: (e.value.drinkModel?.name).toString(),
          ),
        )
        .toList();
    final orderData = OrderModel(
      status: Status.neworder,
      orderDate: DateTime.now(),
      products: listSelectedDrink,
      total: total,
    ).toMap();

    orderData.removeWhere((key, value) => value == null);
    final id = await _allordersDb.add(orderData).then((value) => value.id);
    await _allordersDb.doc(id).update({'id': id});
    return id;
  }
}
