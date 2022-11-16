import 'package:xedu/core/error/exception.dart';
import 'package:xedu/core/platform/network_info.dart';
import 'package:xedu/features/home/data/datasources/banner_local_datasource.dart';
import 'package:xedu/features/home/data/datasources/banner_remote_datasource.dart';
import 'package:xedu/features/home/domain/entity/banner.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:xedu/features/home/domain/repositories/banner_repository.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerLocalDataSource localDataSource;
  final BannerRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  BannerRepositoryImpl({
    required this.localDataSource, 
    required this.remoteDataSource, 
    required this.networkInfo
  });

  @override
  Future<Either<Failure, Banner>>? getBanner() async {
    if(await networkInfo.isConnected){
        try {
        final result = await remoteDataSource.getRemoteBanner();
        localDataSource.cachedBanner(result!);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cachedData = await localDataSource.getLastBanner();
        return Right(cachedData!);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
    
  }
  
}