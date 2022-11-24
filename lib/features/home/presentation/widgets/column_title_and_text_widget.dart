import 'package:flutter/material.dart';
import 'package:xedu/features/report/presentation/widget/container_riwayat_lapor_widget.dart';
import 'package:xedu/widgets/text_widget.dart';

class ColumnTitleAndTextWidget extends StatelessWidget {
  const ColumnTitleAndTextWidget({
    Key? key, required this.title, required this.text, this.isStatus = false,
  }) : super(key: key);

  final String title;
  final String text;
  final bool isStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: '$title :',
          size: 17,
          weight: FontWeight.w600,
        ),
        SizedBox(height: 6),
        isStatus ?
        Container(
          padding: EdgeInsets.fromLTRB(7, 4, 6, 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: textToColor(text)
          ),
          child: CustomTextWidget(
            text: text,
            weight: FontWeight.w500,
            color: Colors.white,
            size: 11,
          ),
        ) : 
        CustomTextWidget(
          text: text,
          isUsedMaxLines: false,
          size: 13,
          color: Color.fromRGBO(65, 65, 65, 1),
          textAlign: TextAlign.justify,
        )
      ],
    );
  }
}