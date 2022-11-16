import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/home/domain/entity/banner.dart';
import 'package:xedu/features/home/domain/repositories/banner_repository.dart';
import 'package:xedu/features/home/domain/usecases/banner_usecase.dart';

class MockBannerRepository extends Mock implements BannerRepository {}

void main() {
  late GetBanner usecase;
  late MockBannerRepository mockBannerRepository;

  setUp((){
    mockBannerRepository = MockBannerRepository();
    usecase = GetBanner(mockBannerRepository);
  });


    final tBannerData = <BannerData>[
      BannerData(id: 1, image: 'image'),
      BannerData(id: 2, image: 'image 2')
    ];
  final tBanner = Banner(banner: tBannerData);

  test('should get bannner from the repository', () async {
    //arrange
    when(()=> mockBannerRepository.getBanner()).thenAnswer((_) async => Right(tBanner));
    //act
    final result = await usecase(NoParams());
    //assert
    expect(result, Right(tBanner));
    verify(() => mockBannerRepository.getBanner());
  });
}