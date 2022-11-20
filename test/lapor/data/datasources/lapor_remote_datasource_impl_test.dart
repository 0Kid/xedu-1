import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:xedu/features/register/data/model/register_model.dart';
import 'package:xedu/features/report/data/datasource/lapor_remote_datasource.dart';
import 'package:xedu/features/report/domain/usecase/post_lapor_usecase.dart';
import 'package:xedu/utils/constant.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../login/data/datasources/login_remote_data_source_test.dart';

void main() {
  late MockHttpClient client;
  late LaporRemoteDatasourceImpl datasource;

  setUp((){
    client = MockHttpClient();
    datasource = LaporRemoteDatasourceImpl(client: client);
  });

  group('post lapor', () {
    final tLaporParams = LaporParams(
      namaPelaku: 'saladut', 
      tempatKejadian: 'bandung', 
      tanggalKejadian: '20 november 2022', 
      hubungan: 'teman', 
      uraian: 'uraian', 
      isAnon: false, 
      authId: 1, 
      sekoalhId: 1, 
      status: 'SUBMITED'
    );

    final tLaporResponse = RegisterModel.fromJson(jsonDecode(fixture('register_response.json')));

    test('should perform post request on URL with email and password as body', () async {
      //arrange
      when(() => client.post(
        Uri.http(URL, '/api/lapor/create'),
        body: {
          "nama_pelaku": tLaporParams.namaPelaku,
          "tempat_kejadian": tLaporParams.tempatKejadian,
          "tanggal_kejadian": tLaporParams.tanggalKejadian,
          "hubungan": tLaporParams.hubungan,
          "uraian": tLaporParams.uraian,
          "authId": tLaporParams.authId,
          "sekolahId": tLaporParams.sekoalhId,
          "status": tLaporParams.status,
          "isAnonym": tLaporParams.isAnon
        }
      ))
        .thenAnswer((_) async => http.Response(fixture('user_data.json'), 200));
      //act
      datasource.postRemoteLapor(tLaporParams);
      //assert
      verify(()=>client.post(
        Uri.http(URL, '/api/lapor/create'),
        body: {
          "nama_pelaku": tLaporParams.namaPelaku,
          "tempat_kejadian": tLaporParams.tempatKejadian,
          "tanggal_kejadian": tLaporParams.tanggalKejadian,
          "hubungan": tLaporParams.hubungan,
          "uraian": tLaporParams.uraian,
          "authId": tLaporParams.authId,
          "sekolahId": tLaporParams.sekoalhId,
          "status": tLaporParams.status,
          "isAnonym": tLaporParams.isAnon
        }
      ));
    });
  });
}