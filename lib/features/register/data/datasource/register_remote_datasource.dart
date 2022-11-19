import 'dart:convert';

import 'package:http/http.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/features/register/data/model/register_model.dart';
import 'package:xedu/utils/constant.dart';

abstract class RegisterRemoteDatasource {
  Future<RegisterModel>? remoteRegister({
    required String email, 
    required String namaLengkap, 
    required int umur, 
    required String alamat, 
    required String noTelp, 
    required int sekolahId, 
    required String jenisKelamin, 
    required String password
  });
}

class RegisterRemoteDatasourceImpl extends RegisterRemoteDatasource {
  final Client client;

  RegisterRemoteDatasourceImpl({required this.client});
  @override
  Future<RegisterModel>? remoteRegister({required String email, required String namaLengkap, required int umur, required String alamat, required String noTelp, required int sekolahId, required String jenisKelamin, required String password}) async {
    final response = await client.post(
      Uri.http(URL, '/api/auth/signup'),
      body: {
        "email": email,
        "nama_lengkap": namaLengkap,
        "umur": umur.toString(),
        "alamat": alamat,
        "notelp": noTelp,
        "sekolahId": sekolahId.toString(),
        "jenis_kelamin": jenisKelamin,
        "password": password
      }
    );
    if(response.statusCode == 200){
      return RegisterModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}