import 'package:flutter/material.dart';
import 'package:rare_crew_test/src/view/utils/my_colors.dart';

class RegButton extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final Color borderColor;
  final FontWeight fontWeight;
  const RegButton(
      {Key? key,
      this.onTap,
      this.fontWeight=FontWeight.w300 ,
      required this.title,
      this.borderColor = MyColors.purpleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(
          color: borderColor,
          width: 0.2,
        )),
        child: Text(
          title,
          style:  TextStyle(
            //fontFamily: 'Roboto',
            fontSize: 13,
            color:const Color(0x80070707),
            fontWeight: fontWeight,
          ),
          softWrap: false,
        ),
      ),
    );
  }
}
