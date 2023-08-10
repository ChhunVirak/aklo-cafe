import 'package:aklo_cafe/module/manage_table/model/table_model.dart';

abstract class TableManagerRepo {
  Stream<List<TableModel>> get getAllTables;
  Future<bool> addTable({required int number});
  Future<bool> updateTable({required String id, required int number});
  Future<void> deleteTable({required String id});
}
