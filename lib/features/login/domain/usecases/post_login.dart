import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/login/domain/entity/user.dart';
import 'package:xedu/features/login/domain/repositories/login_repository.dart';

class PostLogin extends UseCase<UserData, Params>{
  PostLogin(this.repository);

  final LoginRepository? repository;
  
  @override
  Future<Either<Failure, UserData>?> call(Params params) async {
    return await repository?.postLogin(params.email, params.password);
  }
}

class PostLoginAdmin extends UseCase<UserData, Params>{
  final LoginRepository repository;

  PostLoginAdmin({
    required this.repository
  });

  @override
  Future<Either<Failure, UserData>?> call(Params params) async {
    return await repository.postLoginAdmin(params.email, params.password);
  }
  
}

class Params extends Equatable {
  const Params({
    required this.email, 
    required this.password,
  });

  final String email;
  final String password;
  
  @override
  List<Object?> get props => [email, password];
  
}