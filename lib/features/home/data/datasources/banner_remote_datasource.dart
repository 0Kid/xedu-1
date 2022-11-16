import 'dart:convert';

import 'package:http/http.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/features/home/data/models/banner_model.dart';
import 'package:xedu/utils/constant.dart';

abstract class BannerRemoteDataSource {
  Future<BannerModel>? getRemoteBanner();
}

class BannerRemoteDataSourceImpl implements BannerRemoteDataSource {
  final Client client;

  BannerRemoteDataSourceImpl({required this.client});

  @override
  Future<BannerModel>? getRemoteBanner() async {
    final response = await client.get(
      Uri.http(URL, '/api/banner')
    );
    if (response.statusCode == 200) {
      return BannerModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }  
}