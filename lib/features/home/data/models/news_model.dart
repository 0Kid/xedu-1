import 'package:xedu/features/home/domain/entity/news.dart';

class NewsModel extends News {
  NewsModel({required super.data});
  
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      data: List<NewsDataModel>.from(json["data"].map((x)=>NewsDataModel.fromJson(x)))
    );
  }

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((e) => e.toJson()))
  };
}

class NewsDataModel extends NewsData {
  NewsDataModel({required super.id, required super.judul, required super.image, required super.content, required super.createdAt});
  
  factory NewsDataModel.fromJson(Map<String, dynamic> json) {
    return NewsDataModel(
      id: json['id'], 
      judul: json['judul'], 
      image: json['image'], 
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt'])
    );
  }
}