import 'dart:convert';
import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:xedu/features/login/data/model/user_model.dart';
import 'package:xedu/features/login/domain/entity/user.dart';
import 'package:xedu/features/register/data/model/sekolah_model.dart';
import 'package:xedu/features/register/domain/entity/sekolah.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tEmail = 'budi@gmail.com';
  final tSekolah = SekolahModel(id: 1, namaSekolah: 'smpn 1 jatiwangi');
  final tUserData = UserModel(
    id: 1, 
    email: tEmail, 
    namaLengkap: 'budi', 
    alamat: 'bandung', 
    notelp: '1234', 
    jenisKelamin: 'lelaki', 
    sekolahId: 1, 
    sekolah: tSekolah, 
  );
  final tUser = UserDataModel(data: tUserData, token: '1234');

  test('should be a subclass of User entity', () async {
    //assert
    expect(tUser, isA<UserData>());
    //assert
    expect(tUserData, isA<User>());
    //assert
    expect(tSekolah, isA<Sekolah>());
    
  });

  group('fromJson', () {
    test('should return a valid model when the JSON called', () async {
      //arrange
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('user_data.json'));

      //act
      final result = UserDataModel.fromJson(jsonMap);
      print(result.toString());
      //assert
      expect(result, tUser);
    });
  });
}
