import 'package:xedu/features/home/data/models/news_model.dart';

abstract class NewsLocalDatasource {
  Future<NewsModel>? getLastNews();
  Future<void>? cachedNews(NewsModel mews);
}