import 'package:xedu/core/error/exception.dart';
import 'package:xedu/core/platform/network_info.dart';
import 'package:xedu/features/register/data/datasource/register_remote_datasource.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:xedu/features/register/domain/entity/register.dart';
import 'package:xedu/features/register/domain/repositories/register_repository.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  final RegisterRemoteDatasource datasource;
  final NetworkInfo networkInfo;

  RegisterRepositoryImpl({
    required this.datasource, 
    required this.networkInfo
  });
  
  @override
  Future<Either<Failure, Register>>? postRegistration({String? email, String? namaLengkap, int? umur, String? alamat, String? noTelp, int? sekolahId, String? jenisKelamin, String? password}) async {
    if(await networkInfo.isConnected){
      try {
        final response = await datasource.remoteRegister(
          email: email!,
          namaLengkap: namaLengkap!,
          umur: umur!,
          alamat: alamat!,
          noTelp: noTelp!,
          sekolahId: sekolahId!,
          jenisKelamin: jenisKelamin!,
          password: password!
        );
        return Right(response!);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
  
}