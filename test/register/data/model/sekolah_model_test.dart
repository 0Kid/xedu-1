import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:xedu/features/register/data/model/sekolah_model.dart';
import 'package:xedu/features/register/domain/entity/sekolah.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tSekolahModel = SekolahModel(id: 1, namaSekolah: 'smpn 1 jatiwangi');
  final tSekolah = [tSekolahModel];
  final tSekolahDataModel = SekolahDataModel(sekolah: tSekolah);

  test('should be subclass of Sekolah and SekolahData', () {
    //assert
    expect(tSekolahModel, isA<Sekolah>());
    expect(tSekolahDataModel, isA<SekolahData>());
  });

  group('fromJson', () {
    test('shoudl return valid json model ', () async {
      //arrange
      Map<String, dynamic> jsonMap = jsonDecode(fixture('sekolah.json'));
      //act
      final result = SekolahDataModel.fromJson(jsonMap);
      //assert
      expect(result, equals(tSekolahDataModel));
    });
  });
}