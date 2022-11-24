import 'dart:convert';

import 'package:http/http.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/features/login/data/model/user_model.dart';
import 'package:xedu/utils/constant.dart';

abstract class LoginRemoteDataSource {
  Future<UserDataModel>? auth(String? email, String? password);
  Future<UserDataModel>? authAdmin(String? email, String? password);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final Client client;

  LoginRemoteDataSourceImpl({required this.client});

  @override
  Future<UserDataModel>? auth(String? email, String? password) async {
    final response = await client.post(
      Uri.http(URL, '/api/auth/signin'),
      body: {
        "email": email,
        "password": password
      }
    );
    if(response.statusCode == 200){
      return UserDataModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();  
    }
  }
  
  @override
  Future<UserDataModel>? authAdmin(String? email, String? password) async {
    final response = await client.post(
      Uri.http(URL, '/api/sekolah/signin'),
      body: {
        "notelp": email,
        "password": password
      }
    );
    if(response.statusCode == 200){
      return UserDataModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();  
    }
  }
}