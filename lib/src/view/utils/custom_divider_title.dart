import 'package:flutter/material.dart';

class CustomDividerTitle extends StatelessWidget {
  final String title;
  const CustomDividerTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            thickness: 1,
            color: Color(0x29070707),
            indent: 20,
            endIndent: 10,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0x29070707),
            fontWeight: FontWeight.w500,
          ),
          softWrap: false,
        ),
        const Expanded(
          child: Divider(
            thickness: 1,
            color: Color(0x29070707),
            endIndent: 20,
            indent: 10,
          ),
        ),
      ],
    );
  }
}
