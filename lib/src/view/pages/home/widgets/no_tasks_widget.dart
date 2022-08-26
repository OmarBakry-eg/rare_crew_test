

import 'package:flutter/material.dart';

import '../../add_task/screens/add_or_update_task.dart';

class NoTasksWidget extends StatelessWidget {
  const NoTasksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (c) => const AddOrEditTaskScreen())),
      child: const Text(
        "No Tasks for now\nTry adding one!",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: Color(0xff172735),
          letterSpacing: 0.42,
        ),
      ),
    );
  }
}
