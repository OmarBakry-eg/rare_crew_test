import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rare_crew_test/src/resources/database/hive_operations.dart';
import 'package:rare_crew_test/src/view/pages/home/widgets/no_tasks_widget.dart';
import 'package:rare_crew_test/src/view/pages/home/widgets/tasks_list_widget.dart';
import 'package:rare_crew_test/src/view/utils/my_colors.dart';
import 'package:intl/intl.dart' as intl;

import '../../../utils/constants.dart';
import '../../auth/screens/login.dart';
import '../../auth/widgets/reg_button.dart';

class HomeContent extends StatelessWidget {
  final bool isLogout;
  const HomeContent({Key? key, required this.isLogout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Database database = Database();

    return Center(
      heightFactor: 1.8,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 27),
                decoration: const BoxDecoration(
                  color: Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          color: Color(0xff172735),
                          letterSpacing: 0.42,
                        ),
                        children: [
                          TextSpan(
                            text: 'Good Morning',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextSpan(
                            text: ' ',
                          ),
                          TextSpan(
                            text: 'John',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      softWrap: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'TODAY',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 17,
                        color: MyColors.purpleColor,
                        fontWeight: FontWeight.w500,
                      ),
                      softWrap: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      intl.DateFormat.yMd().format(DateTime.now()),
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 17,
                        color: Color(0xff172735),
                        fontWeight: FontWeight.w700,
                      ),
                      softWrap: false,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            isLogout
                ? RegButton(
                    title: 'Logout',
                    fontWeight: FontWeight.w700,
                    borderColor: Colors.red,
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const LoginPage(
                                    isSignup: false,
                                  )));
                    },
                  )
                : ValueListenableBuilder(
                    valueListenable: Hive.box(Constants.taskBoxName).listenable(),
                    builder: (BuildContext context, Box<dynamic> value, Widget? child) {
                      return value.values.toList().isEmpty
                          ? const NoTasksWidget()
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              //  height: MediaQuery.of(context).size.height,
                              decoration: const BoxDecoration(
                                color: Color(0xffffffff),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x29000000),
                                    offset: Offset(0, 3),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: TasksListWidget(
                                tasks: value.values.toList(),
                                database: database,
                              ));
                    },
                  )
          ],
        ),
      ),
    );
  }
}
