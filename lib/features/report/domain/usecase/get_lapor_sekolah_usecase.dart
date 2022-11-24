import 'package:xedu/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/report/domain/entity/lapor.dart';
import 'package:xedu/features/report/domain/repositories/lapor_repository.dart';
import 'package:xedu/features/report/domain/usecase/get_lapor_usecase.dart';

class GetRiwayatLaporSekolah extends UseCase<Lapor, RiwayatLaporParams> {
  final LaporRepository repository;

  GetRiwayatLaporSekolah({required this.repository});

  @override
  Future<Either<Failure, Lapor>?> call(RiwayatLaporParams params) async {
    return await repository.getRiwayatLaporSekolah(params.authId);
  }
}