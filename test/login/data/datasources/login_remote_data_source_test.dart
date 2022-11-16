import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/features/login/data/datasources/login_remote_data_source.dart';
import 'package:xedu/features/login/data/model/user_model.dart';
import 'package:xedu/utils/constant.dart';

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late LoginRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp((){
    mockHttpClient = MockHttpClient();
    dataSource = LoginRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('postLogin', () {
    const tEmail = 'ziamuhamad@gmail.com';
    const tPassword = 'zia123123';
    final tUserModel = UserDataModel.fromJson(jsonDecode(fixture('user_data.json')));

    
    test('should perform post request on URL with email and password as body', () async {
      //arrange
      when(() => mockHttpClient.post(
        Uri.http(URL, '/api/auth/signin'),
        body: {
          "email": tEmail,
          "password": tPassword
        }
      ))
        .thenAnswer((_) async => http.Response(fixture('user_data.json'), 200));
      //act
      dataSource.auth(tEmail, tPassword);
      //assert
      verify(()=>mockHttpClient.post(
        Uri.http(URL, '/api/auth/signin'),
        body: {
          "email": tEmail,
          "password": tPassword
        }
      ));
    });

    test('should returnn UserDataModel when the response is 200 (Success)', () async {
      //arrange
      when(() => mockHttpClient.post(
        Uri.http(URL, '/api/auth/signin'),
        body: {
          "email": tEmail,
          "password": tPassword
        }
      )).thenAnswer((_) async=> http.Response(fixture('user_data.json'), 200));
      //act
      final result = await dataSource.auth(tEmail, tPassword);
      //assert
      expect(result, equals(tUserModel));
    });

    test('should return serverException if response isnt 200', () async {
      //arrange
      when(() => mockHttpClient.post(
        Uri.http(URL, '/api/auth/signin'),
        body: {
          "email": tEmail,
          "password": tPassword
        }
      )).thenAnswer((_) async=> http.Response('Something went wrog', 400));
      //act
      final call = await dataSource.auth;
      //assert
      expect(()=>call(tEmail, tPassword), throwsA(TypeMatcher<ServerException>()));
      
    });
  });
  
}