import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/report/domain/entity/lapor.dart';
import 'package:xedu/features/report/domain/repositories/lapor_repository.dart';

class GetRiwayatLapor extends UseCase<Lapor, RiwayatLaporParams> {
  final LaporRepository repository;

  GetRiwayatLapor({required this.repository});

  @override
  Future<Either<Failure, Lapor>?> call(RiwayatLaporParams params) async {
    return await repository.getRiwayatLapor(params.authId);
  }
}

class RiwayatLaporParams extends Equatable {
  final String authId;

  const RiwayatLaporParams({required this.authId});

  @override
  List<Object?> get props => [authId];
  
}