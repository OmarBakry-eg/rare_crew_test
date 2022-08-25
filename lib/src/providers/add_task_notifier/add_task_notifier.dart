import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/src/resources/database/hive_operations.dart';
import 'package:uuid/uuid.dart';

import '../../models/task_model.dart';

final addOrEditTaskNotifierController =
    ChangeNotifierProvider<AddOrEditTaskNotifierController>(
        (ref) => AddOrEditTaskNotifierController());

class AddOrEditTaskNotifierController extends ChangeNotifier {
  AddOrEditTaskNotifierController() : super();
  final Database database = Database();
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

  Future<bool> addNewTask() async {
    if (formKey.currentState!.validate()) {
      final Task task = Task(
          id: const Uuid().v4(),
          date: DateTime.parse(dateController.text),
          category: categoryController.text,
          taskName: taskNameController.text,
          description: descriptionController.text,
          priority: selectedpriority);
      final bool save = await database.save(task: task);
      return save;
    }
    return false;
  }
}
