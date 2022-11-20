import 'package:flutter/material.dart';
import 'package:xedu/themes/color.dart';

class TextFieldWithLabelWidget extends StatelessWidget {
  const TextFieldWithLabelWidget({
    Key? key, 
    required this.label,
    required this.controller,
    required this.errorMessage
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: kPrimaryColor,
      controller: controller,
      validator: (value) {
        if(value == null || value.isEmpty){
          return errorMessage;
        } else {
          return null;
        }
      },
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
