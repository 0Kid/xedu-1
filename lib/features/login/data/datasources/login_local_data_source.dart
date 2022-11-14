import 'package:xedu/features/login/domain/entity/user.dart';

abstract class LoginLocalDataSource {
  Future<UserData>? getUserDataFromLocal();
  Future<void>? cacheUser(UserData user);
  
}