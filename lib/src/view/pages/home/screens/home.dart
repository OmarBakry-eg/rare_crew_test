import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/src/providers/home_notifier_controller/home_notifier_controller.dart';
import 'package:rare_crew_test/src/view/utils/my_colors.dart';
import 'package:rare_crew_test/src/view/utils/reusable_app_bar.dart';

import '../widgets/home_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final int value = ref.watch(bottomNavBarIndexController);
    // final controller = ref.read(bottomNavBarIndexController.notifier);
    // log('rebuild frrom build');
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final int value = ref.watch(homeNotifierController);
          return IndexedStack(
            index: value,
            children: const [
              HomeContent(
                isLogout: false,
              ),
              HomeContent(
                isLogout: true,
              )
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final HomeNotifierController controller =
                ref.read(homeNotifierController.notifier);
            final int value = ref.watch(homeNotifierController);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    color: MyColors.purpleColor,
                    onPressed: () {
                      controller.changeIndex(0);
                    },
                    icon: Icon(value == 0 ? Icons.home : Icons.home_outlined)),
                IconButton(
                    color: MyColors.purpleColor,
                    onPressed: () {
                      controller.changeIndex(1);
                    },
                    icon: Icon(value == 1 ? Icons.person : Icons.person_outlined))
              ],
            );
          },
        ),
      ),
    );
  }
}
