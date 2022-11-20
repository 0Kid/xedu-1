import 'package:flutter/material.dart';
import 'package:xedu/features/report/presentation/widgets/custom_elevated_button_widget.dart';
import 'package:xedu/features/report/presentation/widgets/radio_with_label_widget.dart';
import 'package:xedu/features/report/presentation/widgets/textfield_with_label_widget.dart';
import 'package:xedu/themes/color.dart';
import 'package:xedu/widgets/text_widget.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ReportScreen();
  }
}

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String groupValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: const Color.fromRGBO(235, 243, 254, 1),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(18, 51, 19, 18),
          padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 22),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                offset: const Offset(0, 4),
                color: Colors.black.withOpacity(.25),
              ),
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              const CustomTextWidget(
                text: 'Pelaporan tindak',
                weight: FontWeight.w600,
                size: 23,
              ),
              const CustomTextWidget(
                text: 'kekerasan seksual',
                weight: FontWeight.w600,
                size: 23,
              ),
              const SizedBox(height: 36,),
              const TextFieldWithLabelWidget(
                label: 'Nama Pelaku: ',
              ),
              const SizedBox(height: 15,),
              const TextFieldWithLabelWidget(label: 'Tangal kejadian:'),
              const SizedBox(height: 15,),
              const TextFieldWithLabelWidget(label: 'Hubunga degan pelaku:'),
              const SizedBox(height: 15,),
              const TextFieldWithLabelWidget(label: 'Peristiwa yang terjadi'),
              const SizedBox(height: 15,),
              radioTitle(),
              const SizedBox(height: 8,),
              radioAnonim(),
              const SizedBox(height: 28,),
              rowButtoWidget()
            ],
          ),
        ),
      ),
    );
  }

  Row rowButtoWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomElevatedButtonWidget(
          backgroundColor: Colors.white,
          isBorderEnabled: true,
          text: 'Batal',
          textColor: kPrimaryColor,
          shadowColor: kPrimaryColor.withOpacity(0.16),
          onTap: () {
            
          },
        ),
        CustomElevatedButtonWidget(
          backgroundColor: kPrimaryColor,
          isBorderEnabled: false,
          text: 'Kirim',
          textColor: Colors.white,
          shadowColor: kPrimaryColor.withOpacity(0.16),
          onTap: () {
            
          },
        ),
      ],
    );
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      title: const CustomTextWidget(
        text: 'Lapor',
        color: Colors.white,
        weight: FontWeight.w600,
        size: 24,
      ),
    );
  }

  Row radioAnonim() {
    return Row(
      children: [
        RadioWithLabelWidget(
          value: 'Ya', 
          label: 'Ya', 
          groupValue: groupValue,
        ),
        RadioWithLabelWidget(
          value: 'Tidak', 
          label: 'Tidak', 
          groupValue: groupValue,
        ),
      ],
    );
  }

  Align radioTitle() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: CustomTextWidget(
        text: 'Lapor secara anonim',
        size: 15,
        weight: FontWeight.w500,
      ),
    );
  }
}
