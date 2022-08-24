import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/src/models/task_model.dart';

final addOrEditTaskNotifierController =
    ChangeNotifierProvider<AddOrEditTaskNotifierController>(
        (ref) => AddOrEditTaskNotifierController());

class AddOrEditTaskNotifierController extends ChangeNotifier {
  AddOrEditTaskNotifierController() : super();

  TextEditingController taskNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  int selectedpriority = 0;
  List<Color> priorityColors = const [
    Color(0xffFC5565),
    Color(0xffFA9B4A),
    Color(0xff58BBF7),
    Color(0xff4CCB41),
  ];
  void selectPriority(int index) {
    selectedpriority = index;
    notifyListeners();
    // state = selectedpriority;
  }
}
