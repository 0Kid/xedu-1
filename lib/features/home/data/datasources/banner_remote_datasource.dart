import 'package:xedu/features/home/data/models/banner_model.dart';

abstract class BannerRemoteDataSource {
  Future<BannerModel>? getRemoteBanner();
}