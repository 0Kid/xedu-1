import 'package:flutter/material.dart';
import 'package:xedu/widgets/text_widget.dart';

class DisabledTexfieldWithLabel extends StatelessWidget {
  const DisabledTexfieldWithLabel({
    super.key, 
    required this.label, 
    required this.isFilled, 
    required this.controller
  });
  final String label;
  final bool isFilled;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: label,
          weight: FontWeight.w600,
          color: Color.fromRGBO(151, 151, 151, 1),
        ),
        SizedBox(height: 8),
        TextField(
          enabled: false,
          controller: controller,
          style: TextStyle(
            fontWeight:isFilled ? FontWeight.w600 : FontWeight.w400,
            fontSize: isFilled ? 14 : 16,
            color: Color.fromRGBO(52, 52 ,52, 1)
          ),
          decoration: InputDecoration(
            filled: isFilled,
            isDense: true,
            fillColor: Color.fromRGBO(248, 239, 255, 1),
            disabledBorder: isFilled ? 
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color.fromRGBO(202, 202, 202, 1),
              ),
            ) :
            UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(202, 202, 202, 1)
              )
            )
          ),
        )
      ],
    );
  }
}