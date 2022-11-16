import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:xedu/features/home/data/models/banner_model.dart';
import 'package:xedu/features/home/domain/entity/banner.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
    final tBannerData = BannerDataModel(id: 1, image: 'image');
    final tListBannerDataModel = <BannerDataModel>[
      tBannerData
    ];
    final tBannerModel = BannerModel(banner: tListBannerDataModel);

  test('should be a sublcass Banned and BannerData', () async {
    //assert
    expect(tBannerData, isA<BannerData>());
    expect(tBannerModel, isA<Banner>());
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      //arange
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('banner.json'));
      //act
      final result = BannerModel.fromJson(jsonMap);
      //assert
      expect(result, equals(tBannerModel));
    });
  });
  
  group('toJson', () {
    test('should retur json from model ', () async {
      //arrange
      final result = tBannerModel.toJson();
      //act
      final expectedMap = jsonDecode(fixture('banner.json'));
      //assert
      expect(result, equals(expectedMap));
    });
  });
}