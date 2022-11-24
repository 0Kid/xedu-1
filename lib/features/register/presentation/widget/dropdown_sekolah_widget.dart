
import 'package:flutter/material.dart';
import 'package:xedu/features/register/domain/entity/sekolah.dart';
import 'package:xedu/widgets/text_widget.dart';

class DropdownSekolahWidget extends StatelessWidget {
  const DropdownSekolahWidget({
    super.key, 
    required this.data, 
    required this.dropdownValue, 
    required this.onChanged
  });
  
  final SekolahData data;
  final int? dropdownValue;
  final Function(int?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromRGBO(120, 120, 120, 1),
          width: 1
        ),
        borderRadius: BorderRadius.circular(7)
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          items: data.sekolah
            .map<DropdownMenuItem<int>>(
                (value) => DropdownMenuItem<int>(value: value.id, child: Text(value.namaSekolah!))
            )
            .toList(),
          onChanged: onChanged,
          hint: const CustomTextWidget(
            text: 'Sekolah',
            size: 14,
            weight: FontWeight.w400,
            color: Color.fromRGBO(120, 120, 120, 1),
          ),
          value: dropdownValue,
        ),
      ),
    );
  }
}