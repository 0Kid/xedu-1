import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/features/home/data/datasources/news_remote_datasource.dart';
import 'package:xedu/features/home/data/models/news_model.dart';
import 'package:xedu/utils/constant.dart';
import 'package:http/http.dart' as http;

import '../../../fixtures/fixture_reader.dart';
import '../../../login/data/datasources/login_remote_data_source_test.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late NewsRemoteDataSourceImpl datasource;

  setUp((){
    mockHttpClient = MockHttpClient();
    datasource = NewsRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get news', () {
    final tNewsModel = NewsModel.fromJson(jsonDecode(fixture('news.json')));

    test('should perform GET request on url', () async {
      //arrange
      when(() => mockHttpClient.get(
        Uri.http(URL, '/api/berita')
      )).thenAnswer((_) async => http.Response(fixture('news.json'), 200));
      //act
      await datasource.getRemoteNews();
      //assert
      verify(() => mockHttpClient.get(
        Uri.http(URL, '/api/berita')
      ));
    });
    test('should return News model when resposne is 200', () async {
      //arrange
      when(() => mockHttpClient.get(
        Uri.http(URL, '/api/berita')
      )).thenAnswer((_) async => http.Response(fixture('news.json'), 200));
      //act
      final result = await datasource.getRemoteNews();
      //assert
      expect(result, equals(tNewsModel));
    });

    test('should return ServerException when status code is not 200', () async {
      //arrange
      when(() => mockHttpClient.get(
        Uri.http(URL, '/api/berita')
      )).thenAnswer((_) async => http.Response('something went wrong', 404));
      //act
      final call = await datasource.getRemoteNews;
      //assert
      expect(()=> call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}