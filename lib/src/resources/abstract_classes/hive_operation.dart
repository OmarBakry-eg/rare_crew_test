import 'package:rare_crew_test/src/models/task_model.dart';

abstract class HiveOperations {
  List<dynamic> readListOfItems();
  bool isOpen(String boxName);
  String? getUserIfExsiting();
  Future<bool> updateItem(int index, Task item);
  Future<bool> saveTask({required Task task});
  Future<bool> open(String boxName);
  Future<bool> setUser({required String email});
  Future<bool> deleteElementFromBox(int index);
  Future<bool> clearBox(String boxName);
}
