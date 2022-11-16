
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:xedu/features/home/domain/entity/banner.dart' as entity;

class SizedBoxCarouselWidget extends StatelessWidget {
  const SizedBoxCarouselWidget({
    Key? key, 
    required this.length, 
    required this.data, 
    required this.isLoading,
  }) : super(key: key);

  final int length;
  final entity.Banner data;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          if(isLoading == true) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 254,
                height: 125,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.grey[400],
                ),
              ),
            );
          } else {
            return Container(
              width: 254,
              height: 125,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.grey[400],
                image: DecorationImage(
                  image: NetworkImage(data.banner[index].image),
                  fit: BoxFit.cover
                ),
              ),
            );
          }
        },
        separatorBuilder: (_, __) => const SizedBox(
          width: 10,
        ),
        itemCount: length,
      ),
    );
  }
}