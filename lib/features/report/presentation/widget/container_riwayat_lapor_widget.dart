import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:xedu/features/report/domain/entity/lapor.dart';
import 'package:xedu/themes/color.dart';
import 'package:xedu/widgets/text_widget.dart';

class ContainerRiwayatLaporWidget extends StatelessWidget {
  const ContainerRiwayatLaporWidget({
    Key? key, required this.length, required this.isLoading, required this.data,
  }) : super(key: key);

  final Lapor data;
  final int length;
  final bool isLoading;

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
                      text: DateFormat.yMMMMd('id').format(data.lapor[index].createdAt),
                      weight: FontWeight.w500,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 11,),
                  CustomTextWidget(
                    text: data.lapor[index].hubungan,
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
          return Container(
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
                  text: DateFormat.yMMMMd('id').format(data.lapor[index].createdAt),
                  weight: FontWeight.w500,
                  size: 15,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 11,),
              CustomTextWidget(
                text: data.lapor[index].hubungan,
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
        );
        }
      }, 
      separatorBuilder: (_,__) => SizedBox(height: 12,), 
      itemCount: isLoading ? 2 : length
    );
  }
}