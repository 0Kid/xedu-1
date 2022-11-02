import 'package:flutter/material.dart';
import 'package:xedu/widgets/text_widget.dart';

class RowImageAndTextWidget extends StatelessWidget {
  const RowImageAndTextWidget({
    Key? key, 
    required this.titleText, 
    required this.subtitleText, 
    required this.image,
    this.titleColor = const Color.fromRGBO(97, 97, 97, 1),
    this.subtitleColor = const Color.fromRGBO(154, 154, 154, 1),
  }) : super(key: key);

  final String titleText;
  final String subtitleText;
  final String image;
  final Color titleColor;
  final Color subtitleColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 41,
          height: 41,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
              text: titleText,
              size: 13,
              weight: FontWeight.w500,
              color: titleColor,
            ),
            CustomTextWidget(
              text: subtitleText,
              size: 11,
              weight: FontWeight.w500,
              color: subtitleColor,
            ),
          ],
        ),
      ],
    );
  }
}
