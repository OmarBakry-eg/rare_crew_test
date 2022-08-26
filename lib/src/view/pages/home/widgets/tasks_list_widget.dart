import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart' as intl;
import '../../../../models/task_model.dart';
import '../../../../resources/database/hive_database.dart';
import '../../../utils/constants.dart';
import '../../add_task/screens/add_or_update_task.dart';

class TasksListWidget extends StatelessWidget {
  final HiveDatabase database;
  final List<dynamic> tasks;
  const TasksListWidget({Key? key, required this.database, required this.tasks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        //  ValueListenableBuilder(
        //     valueListenable: Hive.box(Constants.taskBoxName).listenable(),
        //     builder: (BuildContext context, Box<dynamic> value, Widget? child) {
        //       return
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (c, i) {
              final Task task = tasks[i] as Task;
              return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      // Consumer(builder:
                      //     (BuildContext context, WidgetRef ref, Widget? child) {
                      //   return
                      SlidableAction(
                        onPressed: (context) {
                          database.deleteElementFromBox(i);
                          // ref.read(addOrEditTaskNotifierController).checkTaskList();
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      //  }),
                    ],
                  ),
                  child: ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => AddOrEditTaskScreen(
                                  task: task,
                                  index: i,
                                ))),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              task.category,
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Constants.priorityColors[task.priority],
                              shape: BoxShape.circle,
                              //borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    leading: Text(
                      intl.DateFormat.yMd().format(task.date),
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        color: Color(0xde172735),
                        fontWeight: FontWeight.w500,
                      ),
                      softWrap: false,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          task.taskName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          task.description ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ));
            },
            separatorBuilder: (c, i) => const Divider(
                  thickness: 0.5,
                  height: 10,
                ),
            itemCount: tasks.length);
    // });
  }
}
