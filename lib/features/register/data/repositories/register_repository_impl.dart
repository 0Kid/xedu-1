import 'package:xedu/core/platform/network_info.dart';
import 'package:xedu/features/register/data/datasource/register_remote_datasource.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:xedu/features/register/domain/repositories/register_repository.dart';
import 'package:xedu/features/register/domain/usecase/register_usecase.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  final RegisterRemoteDatasource datasource;
  final NetworkInfo networkInfo;

  RegisterRepositoryImpl({
    required this.datasource, 
    required this.networkInfo
  });

  @override
  Future<Either<Failure, void>>? postRegistration(RegisterParams register) async {
    networkInfo.isConnected;
    return Right(await datasource.remoteRegister(register)!);
  }
  
}