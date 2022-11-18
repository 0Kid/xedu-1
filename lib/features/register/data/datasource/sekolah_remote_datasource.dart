import 'dart:convert';

import 'package:http/http.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/features/register/data/model/sekolah_model.dart';
import 'package:xedu/utils/constant.dart';

abstract class SekolahRemoteDatasource {
  Future<SekolahDataModel>? getRemoteSekolah();
}

class SekolahRemoteDatasourceImpl implements SekolahRemoteDatasource {
  final Client client;

  SekolahRemoteDatasourceImpl({required this.client});

  @override
  Future<SekolahDataModel>? getRemoteSekolah() async {
    final response = await client.get(Uri.http(URL, '/api/sekolah'));
    if(response.statusCode == 200){
      return SekolahDataModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}