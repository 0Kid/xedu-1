import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/home/data/models/banner_model.dart';
import 'package:xedu/features/home/domain/usecases/banner_usecase.dart';
import 'package:xedu/features/home/presentation/bloc/banner_bloc.dart';
import 'package:xedu/features/login/presentation/bloc/login_bloc.dart';


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

    test('sholt emit [BannerInitial, BannerLoading, BannerLoaded', () async*{
      //assert
      when(() => mockGetBanner(NoParams())).thenAnswer((_) async => Right(tBannerModel));
      //expect later
      final expected = [
        BannerInitial(),
        BannerLoading(),
        BannerLoaded(banner: tBannerModel)
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.add(getBannerEvent());
    });

    test('should emit [BannerInitial, BannerLoading, BannerFailed] when failed to get data', () async* {
      //arrange
      when(() => mockGetBanner(NoParams())).thenAnswer((_) async => Left(ServerFailure()));
      //expect later
      final expected = [
        BannerInitial(),
        BannerLoading(),
        BannerFailed(SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.add(getBannerEvent());
    });
  });
}