import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/features/register/data/datasource/register_remote_datasource.dart';
import 'package:xedu/features/register/data/model/register_model.dart';
import 'package:xedu/features/register/domain/entity/register.dart';
import 'package:xedu/features/register/domain/usecase/register_usecase.dart';
import 'package:xedu/utils/constant.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../login/data/datasources/login_remote_data_source_test.dart';

void main() {
  late MockHttpClient mockClient;
  late RegisterRemoteDatasourceImpl datasource;

  setUp((){
    mockClient = MockHttpClient();
    datasource = RegisterRemoteDatasourceImpl(
      client: mockClient
    );
  });

  final tParams = RegisterParams(
      email: 'budi@gmail.com', 
      namaLengkap: 'budi', 
      umur: 22, 
      alamat: 'bandung', 
      noTelp: '1', 
      sekolahId: 1, 
      jenisKelamin: 'pria', 
      password: 'bangkong'
    );
    final tRegisterModel = RegisterModel(
      status: 200,
      message: 'Success'
    );
    Register tRegister  = tRegisterModel;

  test('should post data to remote datasource', () async {
    //arrange
    when(() => mockClient.post(
      Uri.http(URL, '/api/signup'),
      body: {
        "email": tParams.email,
        "nama_lengkap": tParams.namaLengkap,
        "umur": tParams.umur,
        "alamat": tParams.alamat,
        "notelp": tParams.noTelp,
        "sekolahId": tParams.sekolahId,
        "jenis_kelamin": tParams.jenisKelamin,
        "password": tParams.password
      }
    )).thenAnswer((_) async => Response(fixture('register_response.json'), 200));
    //act
    await datasource.remoteRegister(
      email: tParams.email,
        namaLengkap: tParams.namaLengkap,
        umur: tParams.umur,
        alamat: tParams.alamat,
        noTelp: tParams.noTelp,
        sekolahId: tParams.sekolahId,
        jenisKelamin: tParams.jenisKelamin,
        password: tParams.password
    );
    //assert
    verify(() => mockClient.post(
      Uri.http(URL, '/api/signup'),
      body: {
        "email": tParams.email,
        "nama_lengkap": tParams.namaLengkap,
        "umur": tParams.umur,
        "alamat": tParams.alamat,
        "notelp": tParams.noTelp,
        "sekolahId": tParams.sekolahId,
        "jenis_kelamin": tParams.jenisKelamin,
        "password": tParams.password
      }
    ));
  });

  test('should return RegisterModel when response is 200', () async {
    //arrange
    when(() => mockClient.post(
      Uri.http(URL, '/api/signup'),
      body: {
        "email": tParams.email,
        "nama_lengkap": tParams.namaLengkap,
        "umur": tParams.umur,
        "alamat": tParams.alamat,
        "notelp": tParams.noTelp,
        "sekolahId": tParams.sekolahId,
        "jenis_kelamin": tParams.jenisKelamin,
        "password": tParams.password
      }
    )).thenAnswer((_) async => Response(fixture('register_response.json'), 200));
    //act
    final result = await datasource.remoteRegister(
      email: tParams.email,
        namaLengkap: tParams.namaLengkap,
        umur: tParams.umur,
        alamat: tParams.alamat,
        noTelp: tParams.noTelp,
        sekolahId: tParams.sekolahId,
        jenisKelamin: tParams.jenisKelamin,
        password: tParams.password
    );
    //assert
    expect(result, equals(tRegister));
  });

  test('should throw ServerExceotion when response it not 200', () async {
    //arrange
    when(() => mockClient.post(
      Uri.http(URL, '/api/signup'),
      body: {
        "email": tParams.email,
        "nama_lengkap": tParams.namaLengkap,
        "umur": tParams.umur,
        "alamat": tParams.alamat,
        "notelp": tParams.noTelp,
        "sekolahId": tParams.sekolahId,
        "jenis_kelamin": tParams.jenisKelamin,
        "password": tParams.password
      }
    )).thenAnswer((_) async => Response('something went wrong', 400));
    //act
    final call = datasource.remoteRegister;
    //assert
    expect(()=> call(
      email: tParams.email,
        namaLengkap: tParams.namaLengkap,
        umur: tParams.umur,
        alamat: tParams.alamat,
        noTelp: tParams.noTelp,
        sekolahId: tParams.sekolahId,
        jenisKelamin: tParams.jenisKelamin,
        password: tParams.password
    ), 
      throwsA(TypeMatcher<ServerException>())
    );
  });
}