import 'package:xedu/features/home/data/models/news_model.dart';

abstract class NewsRemoteDataSource {
  Future<NewsModel>? getRemoteNews();
}