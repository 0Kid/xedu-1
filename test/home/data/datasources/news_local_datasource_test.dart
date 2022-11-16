import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/features/home/data/datasources/news_local_datasource.dart';
import 'package:xedu/features/home/data/models/news_model.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../login/data/datasources/user_local_data_source_test.dart';

void main() {
  late NewsLocalDatasourceImpl datasource;
  late MockSharedPreference mockSharedPreference;

  setUp((){
    mockSharedPreference = MockSharedPreference();
    datasource = NewsLocalDatasourceImpl(prefs: mockSharedPreference);
  });

  group('get last banner', () {
    final tNewsModel = NewsModel.fromJson(jsonDecode(fixture('news.json')));

    test('should return last news from shared preference', () async {
      //arrange
      when(() => mockSharedPreference.getString(any())).thenReturn((fixture('news.json')));
      //act
      final result = await datasource.getLastNews();
      //assert
      verify(() => mockSharedPreference.getString(CACHED_NEWS));
      expect(result, equals(tNewsModel));
    });

    test('should return CacheExceptin when there is no data cached', () async {
      //arrange
      when(() => mockSharedPreference.getString(any())).thenReturn(null);
      //act
      final call = await datasource.getLastNews;
      //assert
      expect(()=>call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cached news', () {
    final tNewsDataModel = NewsDataModel(id: 1, judul: 'judul', image: 'image', content: 'content');
    final tNewsData = [tNewsDataModel];
    final tNewsModel = NewsModel(data: tNewsData);

    test('should cached data to shared preference', () async {
      //act
      datasource.cachedNews(tNewsModel);
      //assert
      final expectedString = jsonEncode(tNewsModel.toJson());
      verify(() => mockSharedPreference.setString(CACHED_NEWS, expectedString));
    });
  });
}