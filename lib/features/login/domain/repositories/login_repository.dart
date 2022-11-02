import 'package:dartz/dartz.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:xedu/features/login/domain/entity/user.dart';

abstract class LoginRepository {
  Future<Either<Failure, User>>? postLogin(String? email, String? password);
}
