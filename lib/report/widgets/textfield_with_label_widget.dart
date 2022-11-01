import 'package:flutter/material.dart';
import 'package:xedu/themes/color.dart';

class TextFieldWithLabelWidget extends StatelessWidget {
  const TextFieldWithLabelWidget({
    Key? key, 
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: Colors.black,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(208, 208, 208, 1),
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: kPrimaryColor,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
