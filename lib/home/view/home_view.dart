import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xedu/home/widgets/icon_and_app_name_widget.dart';

import 'package:xedu/home/widgets/icon_and_text_widget.dart';
import 'package:xedu/themes/color.dart';
import 'package:xedu/widgets/text_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: kPrimaryColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
        slivers:
          [
            appBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      purpleBoxWidget(context),
                      Column(
                        children: [
                          containerUserDataWidget(),
                          const SizedBox(height: 36,),
                          rowSubAppWidget(),
                          const SizedBox(height: 32,),
                          sizeBoxCarouselWidget(context),
                          const SizedBox(height: 25,),      
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 13),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              color: Color.fromRGBO(242, 224, 255, 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomTextWidget(
                                  text: 'Berita Terbaru',
                                  color: kPurpleTextColor,
                                  weight: FontWeight.w600,
                                  size: 18,
                                ),
                                const SizedBox(height: 18,),
                                ListView.separated(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  primary: false,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => Container(
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
                                        Container(
                                          width: 116,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(3),
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                        const SizedBox(width: 10,),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: const [
                                              CustomTextWidget(
                                                text: 'alsdakljshdalkjdhalkjdhajklsdhajlksdhajskldhaskjdhajskdhaasdasdskdhasdjklashdjklsahdasjlkdhsadkjasjkdhjkas',
                                                weight: FontWeight.w500,
                                                color: kPurpleTextColor,
                                              ),
                                              SizedBox(height: 24,),
                                              CustomTextWidget(
                                                text: '5 Hari yang lalu',
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
                                  separatorBuilder: (context, index) => SizedBox(height: 16,), 
                                  itemCount: 10,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ]
              ),
            )
          ],
        ),
      ),
    );
  }

  SizedBox sizeBoxCarouselWidget(BuildContext context) {
    return SizedBox(
      height: 125,
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 254,
            height: 125,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.grey[400],
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 10,), 
        itemCount: 5,
      ),
    );
  }

  Row rowSubAppWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconAndAppNameWidget(
          image: 'assets/images/book.png',
          name: 'Xedu Belajar',
          onIconTap: () {
            
          },
        ),
        IconAndAppNameWidget(
          image: 'assets/images/video.png',
          name: 'Xedu Video',
          onIconTap: () {
            
          },
        ),
        IconAndAppNameWidget(
          image: 'assets/images/health.png',
          name: 'Xedu Health',
          onIconTap: () {
            
          },
        ),
      ],
    );
  }

  Container containerUserDataWidget() {
    return Container(
      width: 317,
      padding: const EdgeInsets.fromLTRB(15, 9, 15, 13),
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
        children: const [
          RowImageAndTextWidget(
            image: 'test',
            subtitleText: '17 Tahun',
            titleText: 'Pelajar',
          ),
          SizedBox(width: 32,),
          RowImageAndTextWidget(
            image: 'test',
            subtitleText: 'Baleendah',
            titleText: 'SMAN 1',
            subtitleColor: Color.fromRGBO(97, 97, 97, 1),
          ),
        ],
      ),
    );
  }

  Container purpleBoxWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 15,
      margin: EdgeInsets.zero,
      color: kPrimaryColor,
    );
  }

  SliverAppBar appBar() {
    return SliverAppBar(
      toolbarHeight: Platform.isIOS ? 220 : 250,
      flexibleSpace: Container(
        padding: const EdgeInsets.fromLTRB(8, 80, 27, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                'assets/images/logo_primary_bg.png',
                width: 163,
                ),
                const Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 32,
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 22, 0, 0),
              child: CustomTextWidget(
                text: 'Hai Budi,',
                weight: FontWeight.w500,
                size: 17,
                color: Colors.white,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: CustomTextWidget(
                text: 'Bagaimana Kabarmu?',
                weight: FontWeight.w500,
                size: 17,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
