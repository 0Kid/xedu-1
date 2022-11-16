import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xedu/core/error/map_error_to_message.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/home/domain/entity/news.dart';
import 'package:xedu/features/home/domain/usecases/news_usecase.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc({required this.usecase}) : super(NewsInitial()) {
    on<GetNewsEvent>(_onGetNewsEvent);
  }

  final GetNews usecase;
  
  NewsState get initialState => NewsInitial();

  _onGetNewsEvent(
    GetNewsEvent event,
    Emitter<NewsState> emit
  ) async {
    emit(NewsLoading());
    final result = await usecase(NoParams());
    result!.fold(
      (l) => emit(NewsFailed(mapFailureToMessage(l))), 
      (r) => emit(NewsLoaded(r))
    );
  }
}
