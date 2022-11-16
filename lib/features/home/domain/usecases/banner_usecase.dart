import 'package:xedu/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/home/domain/entity/banner.dart';
import 'package:xedu/features/home/domain/repositories/banner_repository.dart';

class GetBanner extends UseCase<Banner, NoParams>{
  final BannerRepository repository;

  GetBanner(this.repository);

  @override
  Future<Either<Failure, Banner>?> call(NoParams params) async {
    return await repository.getBanner();
  }
  
}