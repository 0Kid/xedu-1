import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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

      test('should cache data locallty when call to remote success', () async {
        //arrange
        when(() => remoteDataSource.getRemoteBanner()).thenAnswer((_) async => tBannerModel);
        //act
        await repository.getBanner();
        //assert
        verify(() => remoteDataSource.getRemoteBanner());
        verify(() => localDataSource.cachedBanner(tBanner));
      });
    });
  });
}