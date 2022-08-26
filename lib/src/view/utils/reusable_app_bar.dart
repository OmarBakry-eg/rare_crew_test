import 'package:flutter/material.dart';
import 'package:rare_crew_test/src/view/pages/add_task/screens/add_or_update_task.dart';

import 'my_colors.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool hideAddButton, centerTitle;
  const HomeAppBar({Key? key, this.centerTitle = false, this.hideAddButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        hideAddButton
            ? const Offstage()
            : IconButton(
                iconSize: 30,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const AddOrEditTaskScreen()));
                },
                icon: const Icon(Icons.add_circle_outline_outlined)),
      ],
      centerTitle: centerTitle,
      backgroundColor: MyColors.purpleColor,
      title: const Text.rich(
        TextSpan(
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            color: Color(0xffffffff),
            letterSpacing: 2.016,
          ),
          children: [
            TextSpan(
              text: 'Things',
            ),
            TextSpan(
              text: 'TODoOo',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
        softWrap: false,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
