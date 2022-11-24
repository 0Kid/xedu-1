import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xedu/core/error/map_error_to_message.dart';
import 'package:xedu/features/report/domain/entity/lapor.dart';
import 'package:xedu/features/report/domain/usecase/update_status_lapor_usecase.dart';

part 'update_status_event.dart';
part 'update_status_state.dart';

class UpdateStatusBloc extends Bloc<UpdateStatusEvent, UpdateStatusState> {
  UpdateStatusBloc({required this.usecase}) : super(UpdateStatusInitial()) {
    on<UpdateStatusPatchEvent>(_onUpdateStatusLaporan);
  }

  final UpdateStatusLaporan usecase;

  _onUpdateStatusLaporan(
    UpdateStatusPatchEvent event,
    Emitter<UpdateStatusState> emit
  ) async {
    emit(UpdateStatusLoading());
    final result = await usecase.call(StatusParams(laporanId: event.laporId, status: event.status));
    result!.fold(
      (l) => emit(UpdateStatusFailed(message: mapFailureToMessage(l))), 
      (r) => emit(UpdateStatusSuccess(laporData: r))
    );
  }
}
