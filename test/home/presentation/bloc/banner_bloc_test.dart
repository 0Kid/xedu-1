import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/home/data/models/banner_model.dart';
import 'package:xedu/features/home/domain/usecases/banner_usecase.dart';
import 'package:xedu/features/home/presentation/bloc/banner_bloc.dart';


class MockGetBanner extends Mock implements GetBanner {}

void main() {
  late MockGetBanner mockGetBanner;
  late BannerBloc bloc;

  setUp((){
    mockGetBanner = MockGetBanner();
    bloc = BannerBloc(getBanner: mockGetBanner);
  });

  test('initial state should be BannerInitial', () async {
    expect(bloc.initialState, equals(BannerInitial()));
  });

  group('get banner', () {
    final tBannerData = BannerDataModel(id: 1, image: 'image');
    final tListBannerDataModel = <BannerDataModel>[
      tBannerData
    ];
    final tBannerModel = BannerModel(banner: tListBannerDataModel);
    
    test('should get data from banner use case', () async {
      //arrange
      when(() => mockGetBanner(NoParams())).thenAnswer((_) async => Right(tBannerModel));
      //act
      bloc.add(getBannerEvent());
      await untilCalled(() => mockGetBanner(NoParams()));
      //assert
      verify(() => mockGetBanner(NoParams()));
    });
  });
}