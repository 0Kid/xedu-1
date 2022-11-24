import 'package:dartz/dartz.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:xedu/features/register/domain/entity/register.dart';
import 'package:xedu/features/report/domain/entity/lapor.dart';
import 'package:xedu/features/report/domain/usecase/post_lapor_usecase.dart';

abstract class LaporRepository {
  Future<Either<Failure, Register>>? postLapor(LaporParams params);
  Future<Either<Failure, Lapor>>? getRiwayatLapor(String authId);
  Future<Either<Failure, Lapor>>? getRiwayatLaporSekolah(String sekolahId);
  Future<Either<Failure, UpdateStatus>>? updateStatusLaporan(String laporanId, String status);
}