
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:xedu/features/home/domain/entity/news.dart';
import 'package:xedu/themes/color.dart';
import 'package:xedu/widgets/text_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class ListViewBeritaWidget extends StatelessWidget {
  const ListViewBeritaWidget({super.key, required this.length, required this.data, required this.isLoading, this.onTap});

  final int length;
  final News data;
  final bool isLoading;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 4),
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if(isLoading == true) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(8, 9, 13, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 8,
                    offset: Offset(0, 3),
                    color: Color.fromRGBO(149, 149, 149, .25),
                  )
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          text:
                              data.data[index].judul,
                          weight: FontWeight.w500,
                          color: kPurpleTextColor,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        CustomTextWidget(
                          text: timeago.format(data.data[index].createdAt, locale: 'id'),
                          weight: FontWeight.w500,
                          color: Color.fromRGBO(149, 149, 149, 1),
                          size: 11,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () => onTap!(index),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(8, 9, 13, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 8,
                    offset: Offset(0, 3),
                    color: Color.fromRGBO(149, 149, 149, .25),
                  )
                ],
              ),
              child: Row(
                children: [
                  containerDetailBerita(data.data[index].image),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          text:
                              data.data[index].judul,
                          weight: FontWeight.w500,
                          color: kPurpleTextColor,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        CustomTextWidget(
                          text: timeago.format(data.data[index].createdAt, locale: 'id'),
                          weight: FontWeight.w500,
                          color: Color.fromRGBO(149, 149, 149, 1),
                          size: 11,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 16,
      ),
      itemCount: length,
    );
  }

  Container containerDetailBerita(String image) {
    return Container(
      width: 116,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: Colors.grey[400],
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover
        )
      ),
    );
  }
}