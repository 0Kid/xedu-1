import 'package:equatable/equatable.dart';

class News extends Equatable {
  final List<NewsData> data;

  News({required this.data});

  @override
  List<Object?> get props => [data];
}

class NewsData extends Equatable {
  final int id;
  final String judul;
  final String image;
  final String content;

  NewsData({
    required this.id, 
    required this.judul, 
    required this.image, 
    required this.content
  });

  @override
  List<Object?> get props => [
    id,
    judul,
    image,
    content
  ];
}