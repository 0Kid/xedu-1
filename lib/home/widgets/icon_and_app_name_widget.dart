import 'package:flutter/material.dart';
import 'package:xedu/themes/color.dart';
import 'package:xedu/widgets/text_widget.dart';

class IconAndAppNameWidget extends StatelessWidget {
  const IconAndAppNameWidget({
    Key? key, 
    required this.image, 
    required this.name,
    required this.onIconTap
  }) : super(key: key);
  
  final String image;
  final String name;
  final VoidCallback onIconTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onIconTap,
          child: Container(
            width: 53,
            height: 53,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                  color: Colors.black.withOpacity(.25),
                )
              ],
            ),
            child: Image.asset(image),
          ),
        ),
        const SizedBox(height: 13,),
        CustomTextWidget(
          text: name,
          weight: FontWeight.w500,
          color: kPurpleTextColor,
        )
      ],
    );
  }
}
