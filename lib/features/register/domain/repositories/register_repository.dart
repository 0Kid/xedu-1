import 'package:dartz/dartz.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:xedu/features/register/domain/entity/register.dart';

abstract class RegisterRepository {
  Future<Either<Failure, Register>>? postRegistration(Register register);
}