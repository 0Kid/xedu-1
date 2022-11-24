import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    Key? key, 
    required this.text, 
    this.size = 12, 
    this.weight = FontWeight.w400, 
    this.color = Colors.black,
    this.textAlign = TextAlign.start
  }) : super(key: key);

  final String text;
  final double size;
  final FontWeight weight;
  final Color color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 3,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
