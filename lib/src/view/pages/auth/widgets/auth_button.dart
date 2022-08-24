import 'package:flutter/material.dart';

import '../../../utils/my_colors.dart';

class AuthButton extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  const AuthButton({Key? key, this.onTap, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 200,
        height: 40,
        decoration: BoxDecoration(
          color: MyColors.purpleColor,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: const [
            BoxShadow(
              color: MyColors.shadowColor2,
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: Center(
          child: Text(
           title,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xffffffff),
            ),
            softWrap: false,
          ),
        ),
      ),
    );
  }
}
