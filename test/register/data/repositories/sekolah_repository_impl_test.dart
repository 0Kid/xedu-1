import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:xedu/features/register/data/datasource/sekolah_remote_datasource.dart';
import 'package:xedu/features/register/data/model/sekolah_model.dart';
import 'package:xedu/features/register/data/repositories/sekolah_repository_impl.dart';

import '../../../home/data/repositories/banner_repository_impl_test.dart';

class MockSekolahRemoteDatasource extends Mock implements SekolahRemoteDatasource {}

void main() {
  late MockSekolahRemoteDatasource mockDatasource;
  late MockNetworkInfo mockNetworkInfo;
  late SekolahRepositoryImpl repositoryImpl;

  setUp((){
    mockNetworkInfo = MockNetworkInfo();
    mockDatasource = MockSekolahRemoteDatasource();
    repositoryImpl = SekolahRepositoryImpl(
      remoteDatasource: mockDatasource, 
      networkInfo: mockNetworkInfo
    );
  });
  

  group('get sekolah', () {

    final tSekolahModel = SekolahModel(id: 1, namaSekolah: 'smpn 1 jatiwangi');
    final tSekolah = [tSekolahModel];
    final tSekolahDataModel = SekolahDataModel(sekolah: tSekolah);
    final tSekolahData = tSekolahDataModel;
    group('device is online', () {
      setUp((){
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote data when call to remote success', () async {
        //arrange
        when(() => mockDatasource.getRemoteSekolah()).thenAnswer((_) async => tSekolahDataModel);
        //act
        final result = await repositoryImpl.getSekolah();
        //assert
        verify(()=> mockDatasource.getRemoteSekolah());
        expect(result, equals(Right(tSekolahData)));
      });

      test('should return ServerFailure when call to remote failed', () async {
        //arrange
        when(() => mockDatasource.getRemoteSekolah()).thenThrow(ServerException());
        //act
        final result = await repositoryImpl.getSekolah();
        //assert
        verify(() => mockDatasource.getRemoteSekolah());
        expect(result, Left(ServerFailure()));
      });
    });
  });
}