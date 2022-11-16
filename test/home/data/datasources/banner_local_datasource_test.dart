import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/features/home/data/datasources/banner_local_datasource.dart';
import 'package:xedu/features/home/data/models/banner_model.dart';


import '../../../fixtures/fixture_reader.dart';
import '../../../login/data/datasources/user_local_data_source_test.dart';

void main() {
  late BannerLocalDataSourceImpl datasource;
  late MockSharedPreference mockSharedPreference;

  setUp((){
    mockSharedPreference = MockSharedPreference();
    datasource = BannerLocalDataSourceImpl(
      prefs: mockSharedPreference
    );
  });

  group('get last banner ', () {
    final tBannerModel = BannerModel.fromJson(jsonDecode(fixture('banner.json')));

    test('should return banner from shared preference when there is one in the cache', () async {
      //arrange
      when(() => mockSharedPreference.getString(any())).thenReturn(fixture('banner.json'));
      //act
      final result = await datasource.getLastBanner();
      //assert
      verify(() => mockSharedPreference.getString(CACHED_BANNER));
      expect(result, equals(tBannerModel));
    });

    test('should return cacheException when there is no data cached', () async {
      //arrange
      when(() => mockSharedPreference.getString(any())).thenReturn(null);
      //act
      final call = await datasource.getLastBanner;
      //assert
      expect(()=>call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('Cached banner', () {
    final tBannerData = BannerDataModel(id: 1, image: 'image');
    final tListBannerDataModel = <BannerDataModel>[
      tBannerData
    ];
    final tBannerModel = BannerModel(banner: tListBannerDataModel);

    test('should return shared preference to cache data', () async {
      //act
      datasource.cachedBanner(tBannerModel.toJson());
      //assert
      final expectedString = jsonEncode(tBannerModel.toJson());
      verify(() => mockSharedPreference.setString(CACHED_BANNER, expectedString));
    });
  });
}