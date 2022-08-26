import 'package:hive/hive.dart';
import 'package:rare_crew_test/src/models/task_model.dart';
import '../../view/utils/constants.dart';
import '../abstract_classes/hive_operation.dart';

class HiveDatabase implements HiveOperations {
  @override
  bool isOpen(String boxName) {
    return Hive.isBoxOpen(boxName);
  }

  @override
  Future<bool> open(String boxName) async {
    final bool isOpend = isOpen(boxName);
    if (isOpend) {
      return Future.value(isOpend);
    } else {
      try {
        final Box<dynamic> openHive = await Hive.openBox(boxName);
        if (openHive.isOpen) {
          return true;
        } else {
          Constants.errorMessage(description: 'Cannot open hive $boxName');
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
  Future<bool> saveTask({required Task task}) async {
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
  Future<bool> deleteElementFromBox(int index) async {
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

  // @override
  // Future<bool> setUser({required String email}) async {
  //   try {
  //     await Hive.box(Constants.userBoxName).add(email);
  //     return true;
  //   } catch (e) {
  //     Constants.errorMessage(description: '$e in setUser');
  //     return false;
  //   }
  // }

  @override
  Future<bool> clearBox(String boxName) async {
    try {
      await Hive.box(boxName).clear();
      return true;
    } catch (e) {
      Constants.errorMessage(description: '$e in clearBox');
      return false;
    }
  }
}
