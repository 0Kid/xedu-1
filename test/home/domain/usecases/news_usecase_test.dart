import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/home/domain/entity/news.dart';
import 'package:xedu/features/home/domain/repositories/news_repository.dart';
import 'package:xedu/features/home/domain/usecases/news_usecase.dart';

class MockNewsRepository extends Mock implements NewsRepository {}

void main() {
  late MockNewsRepository mockNewsRepository;
  late GetNews usecase;

  setUp((){
    mockNewsRepository = MockNewsRepository();
    usecase = GetNews(repository: mockNewsRepository);
  });

  final tNewsData = [NewsData(id: 1, judul: 'judul', image: 'image', content: 'content')];
  final tNews = News(data: tNewsData);

  test('should get data from news repository', () async {
    //arrange
    when(() => usecase(NoParams())).thenAnswer((_) async => Right(tNews));
    //act
    final result = await usecase(NoParams());
    //assert
    verify(() => usecase(NoParams()));
    expect(result, equals(Right(tNews)));
  });
}