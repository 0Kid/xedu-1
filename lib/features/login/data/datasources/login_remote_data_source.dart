import 'package:xedu/features/login/domain/entity/user.dart';

abstract class LoginRemoteDataSource {
  Future<UserData>? auth(String? email, String? password);
}