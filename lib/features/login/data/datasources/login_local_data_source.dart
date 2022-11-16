import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/features/login/data/model/user_model.dart';

abstract class LoginLocalDataSource {
  Future<UserDataModel>? getUserDataFromLocal();
  Future<void>? cacheUser(UserDataModel user);
}

const CACHED_USER_DATA = 'CACHED_USER_DATA';

class LoginLocalDataSourceImpl implements LoginLocalDataSource{
  final SharedPreferences sharedPreferences;

  LoginLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void>? cacheUser(UserDataModel user) {
    return sharedPreferences.setString(
      CACHED_USER_DATA,
      json.encode(user)
    );
  }

  @override
  Future<UserDataModel>? getUserDataFromLocal() {
    final data = sharedPreferences.getString('CACHED_USER_DATA');
    if(data != null){
      return Future.value(UserDataModel.fromJson(jsonDecode(data)));
    } else {
      throw CacheException();
    }

  }
}
