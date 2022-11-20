import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/features/register/data/model/register_model.dart';
import 'package:xedu/features/report/data/model/lapor_model.dart';
import 'package:xedu/features/report/domain/usecase/get_lapor_usecase.dart';
import 'package:xedu/features/report/domain/usecase/post_lapor_usecase.dart';
import 'package:xedu/utils/constant.dart';

abstract class LaporRemoteDatasource {
  Future<RegisterModel>? postRemoteLapor(LaporParams params);
  Future<LaporModel>? getRemoteLapor(RiwayatLaporParams params);
}

class LaporRemoteDatasourceImpl extends LaporRemoteDatasource {
  final Client client;

  LaporRemoteDatasourceImpl({required this.client});

  @override
  Future<LaporModel>? getRemoteLapor(RiwayatLaporParams params) async {
    final response = await client.get(
      Uri.http(
        URL, 
        '/api/lapor/byuser',
        {
          'authId': params.authId
        }
      ),
    );
    if(response.statusCode == 200){
      return LaporModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RegisterModel>? postRemoteLapor(LaporParams params) async {
    final response = await client.post(
        Uri.http(
          URL,
          '/api/lapor/create'
        ),
        body: {
          "nama_pelaku": params.namaPelaku,
          "tempat_kejadian": params.tempatKejadian,
          "tanggal_kejadian": params.tanggalKejadian,
          "hubungan": params.hubungan,
          "uraian": params.uraian,
          "authId": params.authId.toString(),
          "sekolahId": params.sekoalhId.toString(),
          "status": params.status,
          "isAnonym": params.isAnon.toString()
        }
    );
    if(response.statusCode == 200){
      return RegisterModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}