import 'package:equatable/equatable.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/register/domain/entity/register.dart';
import 'package:xedu/features/report/domain/repositories/lapor_repository.dart';

class PostLapor extends UseCase<Register, LaporParams> {
  final LaporRepository repository;

  PostLapor({required this.repository});
  
  @override
  Future<Either<Failure, Register>?> call(LaporParams params) async {
    return await repository.postLapor(params);
  }
}

class LaporParams extends Equatable {
  final String namaPelaku;
  final String tempatKejadian;
  final String tanggalKejadian;
  final String hubungan;
  final String uraian;
  final bool isAnon;
  final int authId;
  final int sekoalhId;
  final String status;

  const LaporParams({

    required this.namaPelaku, 
    required this.tempatKejadian, 
    required this.tanggalKejadian,
    required this.hubungan, 
    required this.uraian, 
    required this.isAnon, 
    required this.authId, 
    required this.sekoalhId, 
    required this.status
  });

  @override
  List<Object?> get props => [
    id,
    namaPelaku,
    tempatKejadian,
    tanggalKejadian,
    hubungan,
    uraian,
    uraian,
    isAnon,
    authId,
    sekoalhId,
    status
  ];
}