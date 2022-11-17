import 'package:xedu/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/register/domain/entity/sekolah.dart';
import 'package:xedu/features/register/domain/repositories/sekolah_repository.dart';

class GetSekolah extends UseCase<SekolahData, NoParams> {
  final SekolahRepository repository;

  GetSekolah({required this.repository});

  @override
  Future<Either<Failure, SekolahData>?> call(NoParams params) async {
    return await repository.getSekolah();
  }
  
}