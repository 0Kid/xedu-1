import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/features/report/domain/entity/lapor.dart';
import 'package:xedu/features/report/domain/usecase/get_lapor_usecase.dart';

import 'post_lapor_usecase_test.dart';

void main() {
  late MockLaporRepository mockLaporRepository;
  late GetRiwayatLapor usecase;

  setUp((){
    mockLaporRepository = MockLaporRepository();
    usecase = GetRiwayatLapor(repository: mockLaporRepository);
  });

  final tRiwayatParams = RiwayatLaporParams(authId: '9');

  final tLaporData = LaporData(id: 1, namaPelaku: 'namaPelaku', tempatKejadian: 'tempatKejadian', tanggalKejadian: '22 november 2022', hubungan: 'hubungan', uraian: 'uraian', isAnon: false, status: 'SUBMITTED', createdAt: DateTime.now(), authId: 9, sekoalhId: 1);

  final tListRiwayatLapor = [
    tLaporData,
    tLaporData
  ];

  final tRiwayatLapor = Lapor(lapor: tListRiwayatLapor);

  test('should get riwayat lapor from lapor repository', () async {
    //arrange
    when(() => usecase(tRiwayatParams)).thenAnswer((_) async => Right(tRiwayatLapor));
    //act
    final result = await usecase(tRiwayatParams);
    //assert
    verify(() => mockLaporRepository.getRiwayatLapor(tRiwayatParams.authId));
    expect(result, equals(Right(tRiwayatLapor)));
  });
}