import 'package:dartz/dartz.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/login/domain/entity/user.dart';
import 'package:xedu/features/login/domain/repositories/login_repository.dart';

class GetUserData extends UseCase<UserData, NoParams> {
  GetUserData(this.repository);

  final LoginRepository repository;

  @override
  Future<Either<Failure, UserData>?> call(NoParams params) async {
    return await repository.getUserData();
  }  
}
