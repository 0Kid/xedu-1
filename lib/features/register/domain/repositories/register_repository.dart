import 'package:dartz/dartz.dart';
import 'package:xedu/core/error/failures.dart';

abstract class RegisterRepository {
  Future<Either<Failure, void>>? postRegistration();
}