import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/features/home/data/models/news_model.dart';

const CACHED_NEWS = 'CACHED_NEWS';

abstract class NewsLocalDatasource {
  Future<NewsModel>? getLastNews();
  Future<void>? cachedNews(NewsModel mews);
}

class NewsLocalDatasourceImpl extends NewsLocalDatasource {
  final SharedPreferences prefs;

  NewsLocalDatasourceImpl({required this.prefs});

  @override
  Future<void>? cachedNews(NewsModel mews) {
    return null;
  }

  @override
  Future<NewsModel>? getLastNews() {
    final lastNews = prefs.getString(CACHED_NEWS);
    if(lastNews != null) {
      return Future.value(NewsModel.fromJson(jsonDecode(lastNews)));
    } else {
      throw CacheException();
    }
  }  
}