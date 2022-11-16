import 'package:dartz/dartz.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:xedu/features/home/domain/entity/banner.dart';

abstract class BannerRepository {
  Future<Either<Failure, Banner>>? getBanner();
}