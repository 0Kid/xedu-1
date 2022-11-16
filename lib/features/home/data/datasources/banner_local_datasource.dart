import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/features/home/data/models/banner_model.dart';

const CACHED_BANNER = 'CACHED_BANNER';

abstract class BannerLocalDataSource {
  Future<BannerModel>? getLastBanner();
  Future<void>? cachedBanner(BannerModel BannerDataModel);
}

class BannerLocalDataSourceImpl implements BannerLocalDataSource {
  final SharedPreferences prefs;

  BannerLocalDataSourceImpl({required this.prefs});

  @override
  Future<void>? cachedBanner(BannerDataModel) {
    return prefs.setString(
      CACHED_BANNER,
      jsonEncode(BannerDataModel)
    );
  }

  @override
  Future<BannerModel>? getLastBanner() {
    final lastBanner = prefs.getString(CACHED_BANNER);
    if(lastBanner != null){
      return Future.value(BannerModel.fromJson(jsonDecode(lastBanner)));
    } else {
      throw CacheException();
    }
  }
}