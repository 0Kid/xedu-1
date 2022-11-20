import 'package:xedu/core/error/exception.dart';
import 'package:xedu/core/platform/network_info.dart';
import 'package:xedu/features/report/data/datasource/lapor_local_datasource.dart';
import 'package:xedu/features/report/data/datasource/lapor_remote_datasource.dart';
import 'package:xedu/features/report/domain/entity/lapor.dart';
import 'package:xedu/features/register/domain/entity/register.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:xedu/features/report/domain/repositories/lapor_repository.dart';
import 'package:xedu/features/report/domain/usecase/get_lapor_usecase.dart';
import 'package:xedu/features/report/domain/usecase/post_lapor_usecase.dart';

class LaporRepositoryImpl extends LaporRepository {
  final LaporRemoteDatasource remoteDatasource;
  final LaporLocalDatasource localDatasource;
  final NetworkInfo networkInfo;

  LaporRepositoryImpl({
    required this.remoteDatasource, 
    required this.localDatasource, 
    required this.networkInfo
  });

  @override
  Future<Either<Failure, Lapor>>? getRiwayatLapor(String authId) async {
    if(await networkInfo.isConnected){
      try {
        final response = await remoteDatasource.getRemoteLapor(RiwayatLaporParams(authId: authId));
        return Right(response!);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cachedData = await localDatasource.getLastRiwayatLapor();
        return Right(cachedData!);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
    
  }

  @override
  Future<Either<Failure, Register>>? postLapor(LaporParams params) async {
    if(await networkInfo.isConnected){
      try {
        final response = await remoteDatasource.postRemoteLapor(params);
        return Right(response!);
      } on ServerException {
        return Left(ServerFailure());
      } 
    } else {
      return Left(ServerFailure());
    }
  }
  
}