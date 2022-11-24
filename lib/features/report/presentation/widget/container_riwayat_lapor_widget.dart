import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:xedu/features/report/domain/entity/lapor.dart';
import 'package:xedu/themes/color.dart';
import 'package:xedu/widgets/text_widget.dart';

class ContainerRiwayatLaporWidget extends StatelessWidget {
  const ContainerRiwayatLaporWidget({
    Key? key, required this.length, required this.isLoading, required this.data, this.onTap
  }) : super(key: key);

  final Lapor data;
  final int length;
  final bool isLoading;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(18),
      itemBuilder: (context, index) {
        if(isLoading){
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: CustomTextWidget(
                      text: DateFormat.yMMMMd('id').format(data.lapor[index].createdAt!),
                      weight: FontWeight.w500,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 11,),
                  CustomTextWidget(
                    text: data.lapor[index].hubungan!,
                    weight: FontWeight.w700,
                    size: 24,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 91,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomTextWidget(
                        text: 'Submited',
                        weight: FontWeight.w500,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              onTap!(index);
            },
            child: Container(
            padding: EdgeInsets.fromLTRB(25, 11, 10, 11),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color.fromRGBO(244, 246, 252, 1),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.25),
                  blurRadius: 4,
                  offset: Offset(0, 4)
                )
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: CustomTextWidget(
                    text: data.lapor[index].tanggalKejadian!,
                    weight: FontWeight.w500,
                    size: 11,
                    color: Color.fromRGBO(135, 135, 135, 1),
                  ),
                ),
                SizedBox(height: 11,),
                rowIconAndText(
                  assetPath: 'assets/images/speak.png',
                  text: data.lapor[index].isAnon! ? 'Anonim' : data.lapor[index].namaPelaku!
                ),
                SizedBox(height: 9),
                rowIconAndText(
                  assetPath: 'assets/images/donot.png', 
                  text: data.lapor[index].hubungan!
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 85,
                    height: 26,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: textToColor(data.lapor[index].status!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CustomTextWidget(
                      text: data.lapor[index].status!,
                      weight: FontWeight.w500,
                      size: 13,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
                  ),
          );
        }
      }, 
      separatorBuilder: (_,__) => SizedBox(height: 12,), 
      itemCount: isLoading ? 2 : length
    );
  }

  Row rowIconAndText({
    required String assetPath,
    required String text
  }) {
    return Row(
      children: [
        Image.asset(
          assetPath,
          width: 24,
          height: 24,
          color: Colors.black,
        ),
        SizedBox(width: 15),
        CustomTextWidget(
          text: text,
          size: 15,
          color: Color.fromRGBO(14, 14, 14, 1),
        )
      ],
    );
  }
}

Color textToColor(String status) {
  if(status == 'SUBMITED') {
    return Color.fromRGBO(0, 102, 255, 1);
  } else if(status == 'REVIEW'){
    return Color.fromRGBO(241, 220, 25, 1);
  } else {
    return kGreenColor;
  }
}