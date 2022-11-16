import 'dart:convert';

import 'package:http/http.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/features/home/data/models/news_model.dart';
import 'package:xedu/utils/constant.dart';

abstract class NewsRemoteDataSource {
  Future<NewsModel>? getRemoteNews();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Client client;

  NewsRemoteDataSourceImpl({required this.client});
  @override
  Future<NewsModel>? getRemoteNews() async {
    final response = await client.get(Uri.http(URL, '/api/berita'));
    if (response.statusCode == 200) {
      return NewsModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
  
}