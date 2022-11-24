import 'package:dartz/dartz.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:xedu/features/login/domain/entity/user.dart';

abstract class LoginRepository {
  Future<Either<Failure, UserData>>? postLogin(String? email, String? password);
  Future<Either<Failure, UserData>>? getUserData();
  Future<Either<Failure, UserData>>? postLoginAdmin(String? email, String? password);
}
