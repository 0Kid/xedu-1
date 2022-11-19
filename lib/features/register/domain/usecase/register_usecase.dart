import 'package:equatable/equatable.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/register/domain/entity/register.dart';
import 'package:xedu/features/register/domain/repositories/register_repository.dart';

class PostRegistration extends UseCase<Register, RegisterParams> {
  final RegisterRepository repository;

  PostRegistration({required this.repository});
  
  @override
  Future<Either<Failure, Register>?> call(RegisterParams params) async {
    return await repository.postRegistration(
      email: params.email, 
      namaLengkap: params.namaLengkap, 
      umur: params.umur, 
      alamat: params.alamat, 
      noTelp: params.noTelp, 
      sekolahId: params.sekolahId, 
      jenisKelamin: params.jenisKelamin, 
      password: params.password
    );
  }
}

class RegisterParams extends Equatable {
  final String email;
  final String namaLengkap;
  final int umur;
  final String alamat;
  final String noTelp;
  final int sekolahId;
  final String jenisKelamin;
  final String password;

  const RegisterParams({
    required this.email, 
    required this.namaLengkap, 
    required this.umur, 
    required this.alamat, 
    required this.noTelp, 
    required this.sekolahId, 
    required this.jenisKelamin, 
    required this.password
  });
  @override
  List<Object?> get props => throw UnimplementedError();
  
}