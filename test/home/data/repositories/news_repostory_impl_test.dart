import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:xedu/features/home/data/datasources/news_local_datasource.dart';
import 'package:xedu/features/home/data/datasources/news_remote_datasource.dart';
import 'package:xedu/features/home/data/models/news_model.dart';
import 'package:xedu/features/home/data/repositories/news_repository_impl.dart';
import 'package:xedu/features/home/domain/entity/news.dart';

import '../../../login/data/repositories/login_repository_impl_test.dart';

class MockNewsLocalDatasource extends Mock implements NewsLocalDatasource {}

class MockNewsRemoteDataSource extends Mock implements NewsRemoteDataSource {}

void main() {
  late MockNewsLocalDatasource mockNewsLocalDatasource;
  late MockNewsRemoteDataSource mockNewsRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late NewsRepositoryImpl repository;

  setUp((){
    mockNewsLocalDatasource = MockNewsLocalDatasource();
    mockNewsRemoteDataSource = MockNewsRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NewsRepositoryImpl(
      localDatasource: mockNewsLocalDatasource,
      remoteDatasource: mockNewsRemoteDataSource,
      networkInfo: mockNetworkInfo
    );
  });

  group('get news', () {
    final tNewsData = [NewsDataModel(id: 1, judul: 'judul', image: 'image', content: 'content')];
    final tNewsModel = NewsModel(data: tNewsData);
    final News tNews = tNewsModel;

    test('should return true if device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.getNews();
      //assert
      verify(()=> mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp((){
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote data when call to remote success', () async {
        //arrange
        when(() => mockNewsRemoteDataSource.getRemoteNews()).thenAnswer((_) async => tNewsModel);
        //act
        final result = await repository.getNews();
        //assert
        verify(() => mockNewsRemoteDataSource.getRemoteNews());
        expect(result, equals(Right(tNews)));
      });

      test('should cached data locally when call to remote success', () async {
        //arrange
        when(() => mockNewsRemoteDataSource.getRemoteNews()).thenAnswer((_) async => tNewsModel);
        //act
        await repository.getNews();
        //result
        verify(() => mockNewsRemoteDataSource.getRemoteNews());
        verify(() => mockNewsLocalDatasource.cachedNews(tNewsModel));
      });

      test('should return ServerFailure whe call to remote failed', () async {
        //arrage
        when(() => mockNewsRemoteDataSource.getRemoteNews()).thenThrow(ServerException());
        //act
        final result = await repository.getNews();
        //assert
        verify(() => mockNewsRemoteDataSource.getRemoteNews());
        verifyZeroInteractions(MockLocalDataSource());
        expect(result, Left(ServerFailure()));
      });
    });

    group('device is ofline', () {
      setUp((){
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return last locally cached data', () async {
        //assert
        when(() => mockNewsLocalDatasource.getLastNews()).thenAnswer((_) async => tNewsModel);
        //act
        final result = await repository.getNews();
        //assert
        verify(() => mockNewsLocalDatasource.getLastNews());
        expect(result, equals(Right(tNews)));
      });
    });

    test('should return cached failure when there is no cached data', () async {
      //arrange
      when(() => mockNewsLocalDatasource.getLastNews()).thenThrow(CacheException());
      //act
      final result = await repository.getNews();
      //assert
      verify(() => mockNewsLocalDatasource.getLastNews());
      verifyZeroInteractions(MockRemoteDataSource());
      expect(result, equals(Left(CacheFailure())));
    });
  });
  
}