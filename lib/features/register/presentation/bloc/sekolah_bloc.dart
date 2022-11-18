import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xedu/core/error/map_error_to_message.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/register/domain/entity/sekolah.dart';
import 'package:xedu/features/register/domain/usecase/sekolah_usecase.dart';

part 'sekolah_event.dart';
part 'sekolah_state.dart';

class SekolahBloc extends Bloc<SekolahEvent, SekolahState> {
  SekolahBloc({required this.usecase}) : super(SekolahInitial()) {
    on<GetSekolahEvent>(_onGetSekolahEvent);
  }

  final GetSekolah usecase;
  SekolahState get initialState => SekolahInitial();

  _onGetSekolahEvent(
    GetSekolahEvent event,
    Emitter<SekolahState> emit
  ) async {
    emit(SekolahLoading());
    final result = await usecase(NoParams());
    result!.fold(
      (l) => emit(SekolahFailed(mapFailureToMessage(l))), 
      (r) => emit(SekolahLoaded(r))
    );
  }
}
