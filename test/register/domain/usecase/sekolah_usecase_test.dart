import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/register/domain/entity/sekolah.dart';
import 'package:xedu/features/register/domain/repositories/sekolah_repository.dart';
import 'package:xedu/features/register/domain/usecase/sekolah_usecase.dart';

class MockSekolahRepository extends Mock implements SekolahRepository {}

void main() {
  late MockSekolahRepository mockSekolahRepository;
  late GetSekolah usecase;

  setUp((){
    mockSekolahRepository = MockSekolahRepository();
    usecase = GetSekolah(repository: mockSekolahRepository);
  });

  final tSekolah = [Sekolah(id: 1, namaSekolah: 'smpn 1 jatiwangi')];
  final tSekolahData = SekolahData(sekolah: tSekolah);

  test('should get data from sekolah repository', () async {
    //arrange
    when(() => usecase(NoParams())).thenAnswer((_) async => Right(tSekolahData));
    //act
    final result = await usecase(NoParams());
    //assert
    verify(() => usecase(NoParams()));
    expect(result, equals(Right(tSekolahData)));
  });
}