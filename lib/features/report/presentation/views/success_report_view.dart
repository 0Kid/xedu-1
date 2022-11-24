import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:xedu/themes/color.dart';
import 'package:xedu/widgets/text_widget.dart';

class SuccessReportView extends StatelessWidget {
  const SuccessReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return SuccessReportPage();
  }
}

class SuccessReportPage extends StatelessWidget {
  const SuccessReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 42),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextWidget(
              text: 'Terimakasih telah melaporkan',
              weight: FontWeight.w600,
              size: 23,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 81),
            Icon(
              Icons.check_circle,
              color: kGreenColor,
              size: 120,
            ),
            SizedBox(height: 50),
            CustomTextWidget(
              text: 'Kami akan segera memproses laporanmu, mohon tunggu balasan dari kami',
              weight: FontWeight.w500,
              size: 15,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}