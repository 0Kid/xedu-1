import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:xedu/features/register/data/model/register_model.dart';
import 'package:xedu/features/register/domain/entity/register.dart';
import 'package:xedu/features/report/data/datasource/lapor_local_datasource.dart';
import 'package:xedu/features/report/data/datasource/lapor_remote_datasource.dart';
import 'package:xedu/features/report/data/model/lapor_model.dart';
import 'package:xedu/features/report/data/repositories/lapor_repository_impl.dart';
import 'package:xedu/features/report/domain/entity/lapor.dart';
import 'package:xedu/features/report/domain/usecase/get_lapor_usecase.dart';
import 'package:xedu/features/report/domain/usecase/post_lapor_usecase.dart';

import '../../../home/data/repositories/banner_repository_impl_test.dart';

class MockLaporRemoteDatasource extends Mock implements LaporRemoteDatasource {}
class MockLaporLocalDatasource extends Mock implements LaporLocalDatasource {}

void main() {
  late MockLaporRemoteDatasource mockLaporRemoteDatasource;
  late MockLaporLocalDatasource mockLaporLocalDatasource;
  late MockNetworkInfo mockNetworkInfo;
  late LaporRepositoryImpl repository;

  setUp((){
    mockLaporRemoteDatasource = MockLaporRemoteDatasource();
    mockLaporLocalDatasource = MockLaporLocalDatasource();
    mockNetworkInfo = MockNetworkInfo();
    repository = LaporRepositoryImpl(
      remoteDatasource: mockLaporRemoteDatasource, 
      localDatasource: mockLaporLocalDatasource, 
      networkInfo: mockNetworkInfo
    );
  });

  group('post lapor', () {
    final tLaporParams = LaporParams(
      namaPelaku: 'saladut', 
      tempatKejadian: 'bandung', 
      tanggalKejadian: '20 november 2022', 
      hubungan: 'teman', 
      uraian: 'uraian', 
      isAnon: false, 
      authId: 9, 
      sekoalhId: 1, 
      status: 'SUBMITTED'
    );

    final tResponseModel = RegisterModel(status: 200, message: 'SUCCESS');
    Register tResponse = tResponseModel;

    setUp((){
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test('should return remote data when call to remote success', () async {
      //arrange
      when(() => mockLaporRemoteDatasource.postRemoteLapor(tLaporParams))
        .thenAnswer((_) async => tResponseModel);
      //act
      final result = await repository.postLapor(tLaporParams);
      //assert
      verify(() => mockLaporRemoteDatasource.postRemoteLapor(tLaporParams));
      expect(result, equals(Right(tResponse)));
    });

    test('should return server failure when call to remote failed', () async {
      //arrange
      when(() => mockLaporRemoteDatasource.postRemoteLapor(tLaporParams))
        .thenThrow(ServerException());
      //act
      final result = await repository.postLapor(tLaporParams);
      //assert
      verify(() => mockLaporRemoteDatasource.postRemoteLapor(tLaporParams));
      verifyZeroInteractions(mockLaporLocalDatasource);
      expect(result, equals(Left(ServerFailure())));
    });

    group('get riwayat lapor', () {
      final tRiwayatParams = RiwayatLaporParams(authId: '9');

      final tLaporDataModel = LaporDataModel(id: 1, namaPelaku: 'namaPelaku', tempatKejadian: 'tempatKejadian', tanggalKejadian: '22 november 2022', hubungan: 'hubungan', uraian: 'uraian', isAnon: false, status: 'SUBMITTED', createdAt: DateTime.now(), authId: 9, sekoalhId: 1);
    
      final tListRiwayatLapor = [
        tLaporDataModel,
      ];
    
      final tRiwayatLaporModel = LaporModel(lapor: tListRiwayatLapor);
      Lapor tRiwayatLapor = tRiwayatLaporModel;
      group('device is online', () {
        setUp((){
          when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        });

        test('should return remote data when call to remote datasource success', () async {
          //arrange
          when(() => mockLaporRemoteDatasource.getRemoteLapor(tRiwayatParams))
            .thenAnswer((_) async => tRiwayatLaporModel);
          //act
          final result = await repository.getRiwayatLapor(tRiwayatParams.authId);
          //assert
          verify(() => mockLaporRemoteDatasource.getRemoteLapor(tRiwayatParams));
          expect(result, equals(Right(tRiwayatLapor)));
        });

        test('should return ServerFailure when call to remote data source is failed', () async {
          //arrange
          when(() => mockLaporRemoteDatasource.getRemoteLapor(tRiwayatParams))
            .thenThrow(ServerException());
          //act
          final result = await repository.getRiwayatLapor(tRiwayatParams.authId);
          //expect
          verify(() => mockLaporRemoteDatasource.getRemoteLapor(tRiwayatParams));
          verifyZeroInteractions(mockLaporLocalDatasource);
          expect(result, equals(Left(ServerFailure())));
        });
      });

      group('device is offline', () {
        setUp((){
          when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        });

        test('should return last locally cached data', () async {
          //arrange
          when(() => mockLaporLocalDatasource.getLastRiwayatLapor())
            .thenAnswer((_) async => tRiwayatLaporModel);
          //act
          final result = await repository.getRiwayatLapor(tRiwayatParams.authId);
          //assert
          verifyZeroInteractions(mockLaporRemoteDatasource);
          verify(() => mockLaporLocalDatasource.getLastRiwayatLapor());
          expect(result, equals(Right(tRiwayatLapor)));
        });

        test('should return cachedFailure when thres is no data cached', () async {
          //arrange
          when(() => mockLaporLocalDatasource.getLastRiwayatLapor())
            .thenThrow(CacheException());
          //act
          final result = await repository.getRiwayatLapor(tRiwayatParams.authId);
          //assert
          verifyZeroInteractions(mockLaporRemoteDatasource);
          verify(() => mockLaporLocalDatasource.getLastRiwayatLapor());
          expect(result, equals(Left(CacheFailure())));
        });
      });
    });
  });
}