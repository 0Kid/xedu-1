import 'package:xedu/features/home/data/models/banner_model.dart';

abstract class BannerLocalDataSource {
  Future<BannerModel>? getLastBanner();
  Future<void>? cachedBanner(BannerDataModel);
}