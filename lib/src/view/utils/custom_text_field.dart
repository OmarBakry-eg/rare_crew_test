import 'package:flutter/material.dart';

import 'my_colors.dart';

class CustomTextField extends StatelessWidget {
  final Color? borderColor;
  final String? lable, hint;
  final Widget? prefixIcon;
  final bool isPassword,isMultiline;
  final TextEditingController textEditingController;
  const CustomTextField(
      {Key? key,
      this.borderColor,
      this.hint,
      this.lable,
      this.isMultiline = false,
      this.prefixIcon,
     required this.textEditingController,
      this.isPassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      controller: textEditingController,
      obscureText: isPassword,
      maxLines: isMultiline ? null : 1,
      decoration: InputDecoration(
        
          enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: borderColor ?? MyColors.borderColor, width: 2)),
          focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: borderColor ?? MyColors.borderColor, width: 2)),
          labelText: lable ?? 'title',
          hintText: hint ?? '',
          prefixIconConstraints: const BoxConstraints(maxWidth: 100, maxHeight: 100),
          prefixIcon:
              Padding(padding: const EdgeInsets.only(right: 10), child: prefixIcon)),
    );
  }
}
