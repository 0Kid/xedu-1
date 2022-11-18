import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/features/register/data/datasource/sekolah_remote_datasource.dart';
import 'package:xedu/features/register/data/model/sekolah_model.dart';
import 'package:xedu/utils/constant.dart';
import 'package:http/http.dart' as http;

import '../../../fixtures/fixture_reader.dart';
import '../../../login/data/datasources/login_remote_data_source_test.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late SekolahRemoteDatasourceImpl datasource;

  setUp((){
    mockHttpClient = MockHttpClient();
    datasource = SekolahRemoteDatasourceImpl(
      client: mockHttpClient
    );
  });

  group('get sekolah', () {
    final tSekolahModel = SekolahModel(id: 1, namaSekolah: 'smpn 1 jatiwangi');
    final tSekolah = [tSekolahModel];
    final tSekolahDataModel = SekolahDataModel(sekolah: tSekolah);
    test('get sekolah', () async {
      //arrange
      when(() => mockHttpClient.get(
        Uri.http(URL, '/api/sekolah')
      )).thenAnswer((_) async => http.Response(fixture('sekolah.json'), 200));
      //act
      await datasource.getRemoteSekolah();
      //assert
      verify(() => mockHttpClient.get(
        Uri.http(URL, '/api/sekolah')
      ));
    });

    test('should return SekolahDataModel when response is 200', () async {
      //arrange
      when(() => mockHttpClient.get(
        Uri.http(URL, '/api/sekolah')
      )).thenAnswer((_) async => http.Response(fixture('sekolah.json'), 200));
      //act
      final result = await datasource.getRemoteSekolah();
      //assert
      expect(result, equals(tSekolahDataModel));
    });

    test('should throw serverException when response is not 200', () async {
      //arrange
      when(() => mockHttpClient.get(
        Uri.http(URL, '/api/sekolah')
      )).thenAnswer((_) async => http.Response('something went wrong', 404));
      //act
      final call = datasource.getRemoteSekolah;
      //assert
      expect(()=> call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}