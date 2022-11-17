import 'package:dartz/dartz.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:xedu/features/register/domain/entity/sekolah.dart';

abstract class SekolahRepository {
  Future<Either<Failure, SekolahData>>? getSekolah();
}