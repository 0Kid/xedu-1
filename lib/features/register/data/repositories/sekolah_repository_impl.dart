import 'package:xedu/core/error/exception.dart';
import 'package:xedu/core/platform/network_info.dart';
import 'package:xedu/features/register/data/datasource/sekolah_remote_datasource.dart';
import 'package:xedu/features/register/domain/entity/sekolah.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:xedu/features/register/domain/repositories/sekolah_repository.dart';

class SekolahRepositoryImpl extends SekolahRepository {
  final SekolahRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  SekolahRepositoryImpl({
    required this.remoteDatasource, 
    required this.networkInfo
  });

  @override
  Future<Either<Failure, SekolahData>>? getSekolah() async {
   try {
      final response = await remoteDatasource.getRemoteSekolah();
      return Right(response!);
   } on ServerException {
     return Left(ServerFailure());
   }
  }
}