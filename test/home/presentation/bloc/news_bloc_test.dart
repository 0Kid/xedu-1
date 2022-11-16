import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/home/data/models/news_model.dart';
import 'package:xedu/features/home/domain/usecases/news_usecase.dart';
import 'package:xedu/features/home/presentation/bloc/news_bloc.dart';
import 'package:xedu/features/login/presentation/bloc/login_bloc.dart';

class MockGetNews extends Mock implements GetNews {}

void main() {
  late MockGetNews mockGetNews;
  late NewsBloc bloc;

  setUp((){
    mockGetNews = MockGetNews();
    bloc = NewsBloc(usecase: mockGetNews);
  });

  final tNewsDataModel = NewsDataModel(id: 1, judul: 'judul', image: 'image', content: 'content', createdAt: DateTime.parse('2022-11-13T16:10:09.000Z'));
  final tNewsData = [tNewsDataModel];
  final tNewsModel = NewsModel(data: tNewsData);

  test('initial state should be NewsInitial', () async {
    expect(bloc.initialState, NewsInitial());
  });

  test('should get news data from news usecase', () async {
    //arrange
    when(() => mockGetNews(NoParams())).thenAnswer((_) async => Right(tNewsModel));
    //act
    bloc.add(GetNewsEvent());
    await untilCalled(() => mockGetNews(NoParams()));
    //assert
    verify(() => mockGetNews(NoParams()));
  });

  test('should emit [NewsInitial, Loading, Loaded]', () async* {
    //arrange
    when(() => mockGetNews(NoParams())).thenAnswer((_) async => Right(tNewsModel));
    //assert later
    final expected = [
      NewsInitial(),
      NewsLoading(),
      NewsLoaded(tNewsModel)
    ];
    expectLater(bloc.state, expected);
    //act
    bloc.add(GetNewsEvent());
  });

  test('should emit [NewsInitial, Loading, Failed]', () async* {
    //arrange
    when(() => mockGetNews(NoParams())).thenAnswer((_) async => Right(tNewsModel));
    //assert later
    final expected = [
      NewsInitial(),
      NewsLoading(),
      NewsFailed(SERVER_FAILURE_MESSAGE)
    ];
    expectLater(bloc.state, expected);
    //act
    bloc.add(GetNewsEvent());
  });
}