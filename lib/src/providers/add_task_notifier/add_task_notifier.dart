import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/src/resources/database/hive_database.dart';
import 'package:rare_crew_test/src/view/utils/constants.dart';
import 'package:uuid/uuid.dart';

import '../../models/task_model.dart';

final addOrEditTaskNotifierController =
    ChangeNotifierProvider<AddOrEditTaskNotifierController>(
        (ref) => AddOrEditTaskNotifierController());

class AddOrEditTaskNotifierController extends ChangeNotifier {
  AddOrEditTaskNotifierController() : super();

  final HiveDatabase database = HiveDatabase();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController taskNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  int selectedpriority = 0;
  void selectPriority(int index) {
    selectedpriority = index;
    notifyListeners();
    // state = selectedpriority;
  }

  Future<bool> updateOldTask(int index, Task task) async {
    if (formKey.currentState!.validate()) {
      final Task updatedTask = Task(
          id: task.id,
          date: DateTime.parse(dateController.text),
          category: categoryController.text,
          taskName: taskNameController.text,
          description: descriptionController.text,
          priority: selectedpriority);
      final bool update = await database.updateItem(index, updatedTask);
      if (update) {
        clearTextFields();
      }
      return update;
    }
    return false;
  }

  Future<bool> addNewTask() async {
    if (formKey.currentState!.validate()) {
      final Task task = Task(
          id: const Uuid().v4(),
          date: DateTime.parse(dateController.text),
          category: categoryController.text,
          taskName: taskNameController.text,
          description: descriptionController.text,
          priority: selectedpriority);
      final bool save = await database.saveTask(task: task);
      if (save) {
        clearTextFields();
      }
      return save;
    }
    return false;
  }

  void fillTextFieldsData(Task task) {
    taskNameController.text = task.taskName;
    dateController.text = Constants.formattedDate(task.date);
    categoryController.text = task.category;
    descriptionController.text = task.description ?? '';
  }

  void clearTextFields() {
    taskNameController.clear();
    dateController.clear();
    categoryController.clear();
    descriptionController.clear();
  }
}
