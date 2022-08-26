import 'package:hive/hive.dart';
import 'package:rare_crew_test/src/models/task_model.dart';
import '../../view/utils/constants.dart';

abstract class HiveOperations {
  Future<bool> updateItem(int index, Task item);
  List<dynamic> readListOfItems();
  Future<bool> save({required Task task});
  Future<bool> open();
  Future<bool> delete(int index);
  bool isOpen();
}

class Database implements HiveOperations {
  @override
  bool isOpen() {
    return Hive.isBoxOpen(Constants.taskBoxName);
  }

  @override
  Future<bool> open() async {
    final bool isOpend = isOpen();
    if (isOpend) {
      return Future.value(isOpend);
    } else {
      try {
        final Box<dynamic> openHive = await Hive.openBox(Constants.taskBoxName);
        if (openHive.isOpen) {
          return true;
        } else {
          Constants.errorMessage(description: 'Cannot open hive');
          return false;
        }
      } catch (e) {
        Constants.errorMessage(description: '$e in open method');
        return false;
      }
    }
  }

  @override
  List<dynamic> readListOfItems() {
    final Box item = Hive.box(Constants.taskBoxName);
    return item.values.toList();
  }

  @override
  Future<bool> save({required Task task}) async {
    return await Hive.box(Constants.taskBoxName).add(task).then((value) {
      Constants.errorMessage(
          description: 'Task saved',
          title: "Done",
          onPressed: () {
            Constants.navigatorKey.currentState!.pop();
          });
      return true;
    }).catchError((onError) {
      Constants.errorMessage(description: '$onError in save');
      return false;
    });
  }

  @override
  Future<bool> updateItem(int index, Task item) async {
    try {
      await Hive.box(Constants.taskBoxName).putAt(index, item);
      Constants.errorMessage(
          description: 'Task updated',
          title: "Done",
          onPressed: () {
            Constants.navigatorKey.currentState!.pop();
          });
      return true;
    } catch (e) {
      Constants.errorMessage(description: '$e in update');
      return false;
    }
  }

  @override
  Future<bool> delete(int index) async {
    try {
      await Hive.box(Constants.taskBoxName).deleteAt(index);
      // Constants.errorMessage(description: 'Task deleted', title: "Done");
      return true;
    } catch (e) {
      Constants.errorMessage(
        description: '$e in delete',
      );
      return false;
    }
  }
}
