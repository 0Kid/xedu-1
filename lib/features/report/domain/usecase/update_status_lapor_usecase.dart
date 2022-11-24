import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/report/domain/entity/lapor.dart';
import 'package:xedu/features/report/domain/repositories/lapor_repository.dart';

class UpdateStatusLaporan extends UseCase<UpdateStatus, StatusParams> {
  final LaporRepository repository;

  UpdateStatusLaporan({required this.repository});

  @override
  Future<Either<Failure, UpdateStatus>?> call(StatusParams params) async {
    return await repository.updateStatusLaporan(params.laporanId,params.status);
  }
  
}

class StatusParams extends Equatable{
  final String laporanId;
  final String status;

  const StatusParams({required this.laporanId, required this.status});
  
  @override
  List<Object?> get props => [
    laporanId,
    status
  ];
}