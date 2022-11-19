import 'package:dartz/dartz.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:xedu/features/register/domain/entity/register.dart';

abstract class RegisterRepository {
  Future<Either<Failure, Register>>? postRegistration({
    String email,
    String namaLengkap,
    int umur,
    String alamat,
    String noTelp,
    int sekolahId,
    String jenisKelamin,
    String password
  });
}