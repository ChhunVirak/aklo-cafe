import 'package:aklo_cafe/module/manage_table/controller/manage_table_repo.dart';
import 'package:aklo_cafe/module/manage_table/model/table_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ManageTableController extends GetxController implements TableManagerRepo {
  final _tableDb = FirebaseFirestore.instance.collection('tables');

  @override
  Future<void> deleteTable({required String id}) async {
    await _tableDb.doc(id).delete();
  }

  @override
  Stream<List<TableModel>> get getAllTables =>
      _tableDb.orderBy('number').snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (v) => TableModel.fromMap(
                    v.data(),
                  ),
                )
                .toList(),
          );

  @override
  Future<bool> updateTable({required String id, required int number}) async {
    try {
      final canAdd = await _tableDb
          .where('number', isEqualTo: number)
          .get()
          .then((value) => value.docs.isEmpty);
      if (canAdd == false) {
        return false;
      }
      await _tableDb.doc(id).update({'number': number});
    } catch (e) {
      return false;
    }

    return true;
  }

  @override
  Future<bool> addTable({required int number}) async {
    final canAdd = await _tableDb
        .where('number', isEqualTo: number)
        .get()
        .then((value) => value.docs.isEmpty);
    if (canAdd == false) {
      return false;
    }
    await _tableDb.add(TableModel(number: number).toMap()).then(
          (value) => value.update(
            {
              'id': value.id,
            },
          ),
        );
    return true;
  }

  Future<void> makeAvailable(String tableId) async {
    await _tableDb.doc(tableId).update({
      'currentOrderId': null,
    });
  }

  Future<void> onOrder({
    required String tableId,
    required String currentOrderId,
  }) async {
    await _tableDb.doc(tableId).update({
      'currentOrderId': currentOrderId,
    });
  }
}
