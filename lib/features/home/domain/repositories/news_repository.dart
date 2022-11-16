import 'package:dartz/dartz.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:xedu/features/home/domain/entity/news.dart';

abstract class NewsRepository {
  Future<Either<Failure, News>>? getNews();
}