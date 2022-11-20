import 'dart:convert';
import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:xedu/features/register/data/model/register_model.dart';
import 'package:xedu/features/register/domain/entity/register.dart';
import 'package:xedu/features/report/data/model/lapor_model.dart';
import 'package:xedu/features/report/domain/entity/lapor.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  
  final tLaporDataModel = LaporDataModel(id: 1, namaPelaku: 'namaPelaku', tempatKejadian: 'tempatKejadian', tanggalKejadian: '22 november 2022', hubungan: 'hubungan', uraian: 'uraian', isAnon: false, status: 'SUBMITTED', createdAt: DateTime.parse('2022-11-20T08:28:26.304Z'), authId: 1, sekoalhId: 1);

  final tListRiwayatLaporModel = [
    tLaporDataModel,
  ];

  final tLaporModel = LaporModel(lapor: tListRiwayatLaporModel);
  final tResponse = RegisterModel(status: 200, message: 'Success');

  test('should be subclass of Lapor and LaporData', () {
    //assert
    expect(tLaporModel, isA<Lapor>());
    expect(tLaporDataModel, isA<LaporData>());
  });

  group('post lapor', () {
    group('fromJson', () {
      test('should return valid json model', () {
        //arrange
        Map<String, dynamic> jsonMap = jsonDecode(fixture('register_response.json'));
        //act
        final result = RegisterModel.fromJson(jsonMap);
        //assert
        expect(result, equals(tResponse));
      });
    });
  });

  group('get riwayat lapor', () {
    group('fromJson', () {
      test('should return valid json model', () {
        //arrange
        Map<String, dynamic> jsonMap = jsonDecode(fixture('lapor.json'));
        //act
        final result = LaporModel.fromJson(jsonMap);
        //assert
        expect(result, equals(tLaporModel));
      });
    });
    
    group('toJson', () {
      test('should return json from model', () {
        //arrange
        final result = tLaporModel.toJson();
        //act
        final expectedMap = jsonDecode(fixture('lapor.json'));
        //assert
        expect(result, equals(expectedMap));
      });
    });
  });
}