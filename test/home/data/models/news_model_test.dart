import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:xedu/features/home/data/models/news_model.dart';
import 'package:xedu/features/home/domain/entity/news.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tNewsDataModel = NewsDataModel(id: 1, judul: 'judul', image: 'image', content: 'content', createdAt: DateTime.parse('2022-11-13T16:10:09.000Z'));
  final tNewsData = [tNewsDataModel];
  final tNewsModel = NewsModel(data: tNewsData);

  test('should be subclass of News entiry', () async {
    //expect
    expect(tNewsDataModel, isA<NewsData>());
    expect(tNewsModel, isA<News>());
  });

  group('fromJson', () {
    test('should return valid json model', () async {
      //arrange
      Map<String, dynamic> jsonMap = jsonDecode(fixture('news.json'));
      //act
      final result = NewsModel.fromJson(jsonMap);
      //assert
      expect(result, equals(tNewsModel));
    });
  });

  group('toJson', () {
    test('should return json from model', () async {
      //arange
      final result = tNewsModel.toJson();
      //act
      final expectedMap = jsonDecode(fixture('news.json'));
      //assert
      expect(result, equals(expectedMap));
    });
  });
}