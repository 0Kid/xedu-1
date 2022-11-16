import 'package:xedu/core/error/exception.dart';
import 'package:xedu/core/platform/network_info.dart';
import 'package:xedu/features/home/data/datasources/news_local_datasource.dart';
import 'package:xedu/features/home/data/datasources/news_remote_datasource.dart';
import 'package:xedu/features/home/domain/entity/news.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:xedu/features/home/domain/repositories/news_repository.dart';

class NewsRepositoryImpl extends NewsRepository {
  final NewsLocalDatasource localDatasource;
  final NewsRemoteDataSource remoteDatasource;
  final NetworkInfo networkInfo;

  NewsRepositoryImpl({
    required this.localDatasource, 
    required this.remoteDatasource, 
    required this.networkInfo
  });

  @override
  Future<Either<Failure, News>>? getNews() async {
    if(await networkInfo.isConnected){
      try {
        final response = await remoteDatasource.getRemoteNews();
        localDatasource.cachedNews(response!);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cachedData = await localDatasource.getLastNews();
        return Right(cachedData!);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}