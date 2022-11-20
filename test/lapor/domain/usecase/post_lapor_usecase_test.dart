import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/features/register/domain/entity/register.dart';
import 'package:xedu/features/report/domain/entity/lapor.dart';
import 'package:xedu/features/report/domain/repositories/lapor_repository.dart';
import 'package:xedu/features/report/domain/usecase/post_lapor_usecase.dart';

class MockLaporRepository extends Mock implements LaporRepository {}

void main() {
  late MockLaporRepository mockRepository;
  late PostLapor usecaseLapor;

  setUp((){
    mockRepository = MockLaporRepository();
    usecaseLapor = PostLapor(repository: mockRepository);
  });

  final tLaporParams = LaporParams(
    namaPelaku: 'saladut', 
    tempatKejadian: 'bandung', 
    tanggalKejadian: '20 november 2022', 
    hubungan: 'teman', 
    uraian: 'uraian', 
    isAnon: false, 
    authId: 9, 
    sekoalhId: 1, 
    status: 'SUBMITTED'
  );

  final tResponse = Register(status: 200, message: 'SUCCESS');

  test('should post from lapor repository', () async {
    //arrange
    when(() => usecaseLapor(tLaporParams)).thenAnswer((_) async => Right(tResponse));
    //act
    final result = await usecaseLapor(tLaporParams);
    //assert
    verify(() => mockRepository.postLapor(tLaporParams));
    expect(result, equals(Right(tResponse)));
  });
}