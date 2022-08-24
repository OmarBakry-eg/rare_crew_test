import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/src/providers/add_task_notifier/add_task_notifier.dart';
import 'package:rare_crew_test/src/view/pages/auth/widgets/auth_button.dart';
import 'package:rare_crew_test/src/view/utils/custom_text_field.dart';
import 'package:rare_crew_test/src/view/utils/reusable_app_bar.dart';
import '../../../utils/my_colors.dart';

class AddOrEditTaskScreen extends StatelessWidget {
  const AddOrEditTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(
        hideAddButton: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(width: 2.0, color: MyColors.borderColor),
                boxShadow: const [
                  BoxShadow(
                    color: MyColors.shadowColor,
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Consumer(builder: (context, ref, child) {
                //final Task task = ref.watch(addOrEditTaskNotifierController);
                final AddOrEditTaskNotifierController controller =
                    ref.read(addOrEditTaskNotifierController.notifier);
                return Column(
                  children: [
                    CustomTextField(
                      textEditingController: controller.taskNameController,
                      lable: 'Task Name',
                      hint: 'Task name',
                    ),
                    const Divider(
                      color: MyColors.borderColor,
                    ),
                    CustomTextField(
                      textEditingController: controller.descriptionController,
                      lable: 'Description',
                      hint: 'description',
                      isMultiline: true,
                    ),
                    const Divider(
                      color: MyColors.borderColor,
                    ),
                    CustomTextField(
                      lable: 'Category',
                      hint: 'category',
                      textEditingController: controller.categoryController,
                    ),
                    const Divider(
                      color: MyColors.borderColor,
                    ),
                    CustomTextField(
                      lable: 'Pick Date',
                      hint: 'pick date & time',
                      textEditingController: controller.dateController,
                    ),
                  ],
                );
              }),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Priority',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                color: Color(0xff172735),
                fontWeight: FontWeight.w500,
              ),
              softWrap: false,
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final AddOrEditTaskNotifierController task =
                  ref.watch(addOrEditTaskNotifierController);
              final AddOrEditTaskNotifierController controller =
                  ref.read(addOrEditTaskNotifierController.notifier);
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 2.0, color: MyColors.borderColor),
                        boxShadow: const [
                          BoxShadow(
                            color: MyColors.shadowColor,
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (c, i) => InkWell(
                                onTap: () {
                                  controller.selectPriority(i);
                                  print("clicked");
                                  print(controller.selectedpriority);
                                },
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    border: task.selectedpriority != i
                                        ? null
                                        : Border.all(color: Colors.black45, width: 2),
                                    color: controller.priorityColors[i],
                                    shape: BoxShape.circle,
                                    //borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                                  ),
                                ),
                              ),
                          separatorBuilder: (c, i) => const SizedBox(
                                width: 20,
                              ),
                          itemCount: controller.priorityColors.length)));
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: AuthButton(
              title: 'Add task',
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      )),
    );
  }
}
