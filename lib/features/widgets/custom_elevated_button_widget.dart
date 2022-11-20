import 'package:flutter/material.dart';
import 'package:xedu/themes/color.dart';
import 'package:xedu/widgets/text_widget.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  const CustomElevatedButtonWidget({
    Key? key, 
    required this.backgroundColor, 
    required this.text, 
    required this.onTap, 
    required this.textColor, 
    required this.isBorderEnabled,
    this.shadowColor = kPrimaryColor
  }) : super(key: key);

  final Color backgroundColor;
  final String text;
  final VoidCallback onTap;
  final Color textColor;
  final bool isBorderEnabled;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 82,
      height: 44,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 30,
            offset: const Offset(0, 2),
            color: kPrimaryColor.withOpacity(0.30),
          )
        ],
        borderRadius: BorderRadius.circular(8)
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: isBorderEnabled ? textColor : backgroundColor,
              width: 2
            ),
          ),
        ), 
        child: CustomTextWidget(
          text: text,
          color: textColor,
          weight: FontWeight.w600,
          size: 13,
        ),
      ),
    );
  }
}
