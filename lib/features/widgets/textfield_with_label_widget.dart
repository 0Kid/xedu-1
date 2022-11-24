import 'package:flutter/material.dart';
import 'package:xedu/themes/color.dart';

class TextFieldWithLabelWidget extends StatelessWidget {
  const TextFieldWithLabelWidget({
    Key? key, 
    required this.label,
    required this.controller,
    required this.errorMessage,
    this.isEnabled = true,
    required this.hintText
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final String errorMessage;
  final bool isEnabled;
  final String hintText;

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
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 5,
      enabled: isEnabled,
      decoration: InputDecoration(
        label: Text(label),
        hintText: hintText,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: Colors.black,
        ),
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 11,
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
