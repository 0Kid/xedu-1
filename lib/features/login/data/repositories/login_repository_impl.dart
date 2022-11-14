import 'package:xedu/core/error/exception.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:xedu/core/platform/network_info.dart';
import 'package:xedu/features/login/data/datasources/login_local_data_source.dart';
import 'package:xedu/features/login/data/datasources/login_remote_data_source.dart';
import 'package:xedu/features/login/domain/entity/user.dart';
import 'package:xedu/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository{
  final LoginRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl({
    required this.remoteDataSource, 
    required this.localDataSource, 
    required this.networkInfo
  });

  @override
  Future<Either<Failure, UserData>>? getUserData() async {
    try {
      final data = await localDataSource.getUserDataFromLocal();
      return Right(data!);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UserData>>? postLogin(String? email, String? password) async {
    networkInfo.isConnected;
    try {
      final response = await remoteDataSource.auth(email, password);
      localDataSource.cacheUser(response!);
      return Right(response);
    } on ServerException{
      return Left(ServerFailure());
    }
  }
}