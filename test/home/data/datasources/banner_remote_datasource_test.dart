import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/features/home/data/datasources/banner_remote_datasource.dart';
import 'package:xedu/features/home/data/models/banner_model.dart';
import 'package:xedu/utils/constant.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../login/data/datasources/login_remote_data_source_test.dart';
import 'package:http/http.dart' as http;

void main() {
  late MockHttpClient mockHttpClient;
  late BannerRemoteDataSourceImpl datasource;

  setUp((){
    mockHttpClient = MockHttpClient();
    datasource = BannerRemoteDataSourceImpl(
      client: mockHttpClient
    );
  });

  group('get banner', () {
    final tBannerModel = BannerModel.fromJson(jsonDecode(fixture('banner.json')));
    test('should perform get request on URL', () async {
      //arrange
      when(() => mockHttpClient.get(
        Uri.http(URL, '/api/banner')
      )).thenAnswer((_) async => http.Response(fixture('banner.json'), 200));
      //act
      datasource.getRemoteBanner();
      //assert
      verify(() => mockHttpClient.get(
        Uri.http(URL, '/api/banner')
      ));
    });

    test('should return Banner when response code is 200', () async {
      //arrange
      when(() => mockHttpClient.get(
        Uri.http(URL, '/api/banner')
      )).thenAnswer((_) async => http.Response(fixture('banner.json'), 200));
      //act
      final result = await datasource.getRemoteBanner();
      //
      expect(result, equals(tBannerModel));
    });

    test('should return ServerException when response code beside 200', () async {
      //arrange
      when(() => mockHttpClient.get(
        Uri.http(URL, '/api/banner')
      )).thenAnswer((_) async => http.Response('somethinge went wrong', 404));
      //act
      final call = await datasource.getRemoteBanner;
      //assert
      expect(()=> call(), throwsA(TypeMatcher<ServerException>()));
    });
  });


}