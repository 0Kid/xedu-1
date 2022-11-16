import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:xedu/core/platform/network_info.dart';
import 'package:xedu/features/home/data/datasources/banner_local_datasource.dart';
import 'package:xedu/features/home/data/datasources/banner_remote_datasource.dart';
import 'package:xedu/features/home/data/models/banner_model.dart';
import 'package:xedu/features/home/data/repositories/banner_repository_impl.dart';
import 'package:xedu/features/home/domain/entity/banner.dart';

class MockBannerLocalDataSource extends Mock implements BannerLocalDataSource {}

class MockBannerRemoteDataSource extends Mock implements BannerRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockBannerLocalDataSource localDataSource;
  late MockBannerRemoteDataSource remoteDataSource;
  late MockNetworkInfo networkInfo;
  late BannerRepositoryImpl repository;

  setUp((){
    localDataSource = MockBannerLocalDataSource();
    remoteDataSource = MockBannerRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repository = BannerRepositoryImpl(localDataSource: localDataSource, remoteDataSource: remoteDataSource, networkInfo: networkInfo);
  });

  group('get bannner', () {
    final tBannerData = BannerDataModel(id: 1, image: 'image');
    final tListBannerDataModel = <BannerDataModel>[
      tBannerData
    ];
    final tBannerModel = BannerModel(banner: tListBannerDataModel);
    final Banner tBanner = tBannerModel;

    test('should check if device is onlune', (){
      //arrange
      when(()=> networkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.getBanner();
      //assert
      verify(()=> networkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(()=> networkInfo.isConnected).thenAnswer((_) async => true);
      });
      test('should return remote data whe call to remote is successfull', () async {
        //arrage
        when(() => remoteDataSource.getRemoteBanner()).thenAnswer((_) async => tBannerModel);
        //act
        final result = await repository.getBanner();
        //assert
        verify(()=> remoteDataSource.getRemoteBanner());
        expect(result, equals(Right(tBanner)));
      });

      test('should cache data locally when call to remote success', () async {
        //arrange
        when(() => remoteDataSource.getRemoteBanner()).thenAnswer((_) async => tBannerModel);
        //act
        await repository.getBanner();
        //assert
        verify(() => remoteDataSource.getRemoteBanner());
        verify(() => localDataSource.cachedBanner(tBanner));
      });

      test('should return server failure when call to remote repository failed', () async {
        //arrange
        when(() => remoteDataSource.getRemoteBanner()).thenThrow(ServerException());
        //act
        final result = await repository.getBanner();
        //assert
        verify(()=> remoteDataSource.getRemoteBanner());
        verifyZeroInteractions(localDataSource);
        expect(result, equals(Left(ServerFailure())));
        
      });
    });

    group('device is offline', () {
      setUp((){
        when((() => networkInfo.isConnected)).thenAnswer((_) async => false);
      });

      test('should return last locally cached data', () async {
        //arrange
        when(() => localDataSource.getLastBanner()).thenAnswer((_) async => tBannerModel);
        //act
        final result = await repository.getBanner();
        //assert
        verifyZeroInteractions(remoteDataSource);
        verify(() => localDataSource.getLastBanner());
        expect(result, equals(Right(tBanner)));
      });

      test('should return cacheFailure when there is no data cached', () async {
        //arrange
        when(() => localDataSource.getLastBanner()).thenThrow(CacheException());
        //act
        final result = await repository.getBanner();
        //assert
        verifyZeroInteractions(remoteDataSource);
        verify(() => localDataSource.getLastBanner());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}