import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xedu/features/home/domain/entity/news.dart';
import 'package:xedu/widgets/text_widget.dart';

class DetailBeritaView extends StatelessWidget {
  const DetailBeritaView({super.key, required this.news});

  final NewsData news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 24),
        children: [
          textTitle(),
          SizedBox(height: 21),
          textDate(),
          SizedBox(height: 28),
          containerImage(),
          SizedBox(height: 21),
          CustomTextWidget(
            text: news.content,
            size: 11,
            isUsedMaxLines: false,
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }

  Container containerImage() {
    return Container(
      height: 153,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(news.image),
          fit: BoxFit.cover
        )
      ),
    );
  }

  CustomTextWidget textDate() {
    return CustomTextWidget(
      text: DateFormat('EEEE, d MMMM, y H:m WIB', 'id').format(news.createdAt)
    );
  }

  CustomTextWidget textTitle() {
    return CustomTextWidget(
      text: news.judul,
      weight: FontWeight.w600,
      size: 16,
      color: Colors.black,
    );
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: const CustomTextWidget(
        text: 'Berita terkini',
        color: Colors.white,
        weight: FontWeight.w600,
        size: 24,
      ),
    );
  }
}