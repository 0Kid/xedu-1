import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xedu/core/error/map_error_to_message.dart';
import 'package:xedu/features/report/domain/entity/lapor.dart';
import 'package:xedu/features/report/domain/usecase/get_lapor_sekolah_usecase.dart';
import 'package:xedu/features/report/domain/usecase/get_lapor_usecase.dart';

part 'status_pelaporan_event.dart';
part 'status_pelaporan_state.dart';

class StatusPelaporanBloc extends Bloc<StatusPelaporanEvent, StatusPelaporanState> {
  StatusPelaporanBloc({required this.usecase}) : super(StatusPelaporanInitial()) {
    on<StatusPelaporanGetEvent>(_onStatusPelaporanGetEvent);
  }

  final GetRiwayatLaporSekolah usecase;

  _onStatusPelaporanGetEvent(
    StatusPelaporanGetEvent event,
    Emitter<StatusPelaporanState> emit
  ) async {
    emit(StatusPelaporanLaporLoading());
    final result = await usecase.call(RiwayatLaporParams(authId: event.sekolahId));
    result!.fold(
      (l) => emit(StatusPelaporanLaporFailed(message: mapFailureToMessage(l))), 
      (r) => emit(StatusPelaporanLaporLoaded(lapor: r))
    );
  }
}
