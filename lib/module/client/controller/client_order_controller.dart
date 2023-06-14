import 'package:get/get.dart';

import '../../inventory/model/drink_model.dart';
import '../model/client_order_model.dart';

class ClientOrderController extends GetxController {
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
  }

  num get total => _listOrder.isNotEmpty
      ? _listOrder.entries
          .map<num>((e) => e.value.unit * (e.value.drinkModel?.unitPrice ?? 0))
          .reduce((a, b) => a + b)
      : 0;
}
