import 'package:xedu/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/home/domain/entity/news.dart';
import 'package:xedu/features/home/domain/repositories/news_repository.dart';

class GetNews extends UseCase<News, NoParams> {
  final NewsRepository repository;

  GetNews({required this.repository});
  @override
  Future<Either<Failure, News>?> call(NoParams params) async {
    return await repository.getNews();
  }
}