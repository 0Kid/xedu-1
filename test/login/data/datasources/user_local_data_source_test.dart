import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/features/login/data/datasources/login_local_data_source.dart';
import 'package:xedu/features/login/data/model/user_model.dart';
import 'package:xedu/features/register/data/model/sekolah_model.dart';

import '../../../fixtures/fixture_reader.dart';

class MockSharedPreference extends Mock implements SharedPreferences {}
void main() {
  late LoginLocalDataSourceImpl dataSource;
  late MockSharedPreference mockSharedPreference;

  setUp(() async {
    mockSharedPreference = MockSharedPreference();
    dataSource = LoginLocalDataSourceImpl(sharedPreferences: mockSharedPreference);
  });

  group('get Cached Data', () {
    final tUserDataModel = UserDataModel.fromJson(jsonDecode(fixture('user_data.json')));
    test('should return user data from shared preference', () async {
      //arrange
      when(() => mockSharedPreference.getString(any())).thenReturn(fixture('user_data.json'));
      //act
      final result = await dataSource.getUserDataFromLocal();
      //assert
      verify(() => mockSharedPreference.getString('CACHED_USER_DATA'));
      expect(result, equals(tUserDataModel));
    });

    test('should return CacheException when there is no data ', () async {
      //arrange
      when((() => mockSharedPreference.getString(any()))).thenReturn(null);
      //act
      final call = dataSource.getUserDataFromLocal;
      //assert
      expect(()=>call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cachedUserData', () {
    
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

    test('should call SharedPreference to cached data', () async {
      //act
      dataSource.cacheUser(tUser);
      //assert
      final expectedJsonString = jsonEncode(tUser.toJson());
      print(expectedJsonString);
      verify(() => mockSharedPreference.setString(CACHED_USER_DATA, expectedJsonString));
    });
  });

}
