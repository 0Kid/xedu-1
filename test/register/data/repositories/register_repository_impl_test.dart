import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/features/register/data/datasource/register_remote_datasource.dart';
import 'package:xedu/features/register/data/model/register_model.dart';
import 'package:xedu/features/register/data/repositories/register_repository_impl.dart';
import 'package:xedu/features/register/domain/entity/register.dart';
import 'package:xedu/features/register/domain/usecase/register_usecase.dart';

import '../../../home/data/repositories/banner_repository_impl_test.dart';

class MockRegisterRemoteDataSource extends Mock implements RegisterRemoteDatasource {}

void main() {
  late MockRegisterRemoteDataSource mockRegisterRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late RegisterRepositoryImpl repositoryImpl;
  
  setUp((){
    mockRegisterRemoteDataSource = MockRegisterRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = RegisterRepositoryImpl(
      datasource: mockRegisterRemoteDataSource, 
      networkInfo: mockNetworkInfo
    );
  });

  group('post registration', () {
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
      email: 'budi@gmail.com', 
      namaLengkap: 'budi', 
      umur: 22, 
      alamat: 'bandung', 
      noTelp: '1', 
      sekolahId: 1, 
      jenisKelamin: 'pria', 
      password: 'bangkong'
    );
    Register tRegister  = tRegisterModel;
  });

  setUp(() {
    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
  });
  
  test('should post data to remote datasource when call success', () async {
    //arrange
    when(() => mockRegisterRemoteDataSource.remoteRegister(email, namaLengkap, umur, alamat, noTelp, sekolahId, jenisKelamin, password))
  });
}