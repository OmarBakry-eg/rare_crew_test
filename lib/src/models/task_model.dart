
import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String taskName;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final String category;
  @HiveField(4)
  final DateTime date;

  const Task(
      {required this.id,
      this.description,
     required this.date ,
      required this.category,
      required this.taskName})
      : assert(taskName != '');
}
