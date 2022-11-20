import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xedu/core/error/map_error_to_message.dart';
import 'package:xedu/features/report/domain/entity/lapor.dart';
import 'package:xedu/features/report/domain/usecase/get_lapor_usecase.dart';
import 'package:xedu/features/report/domain/usecase/post_lapor_usecase.dart';

part 'lapor_event.dart';
part 'lapor_state.dart';

class LaporBloc extends Bloc<LaporEvent, LaporState> {
  LaporBloc({
    required this.laporUsecase, 
    required this.riwayatUsecase
  }) : super(LaporInitial()) {
    on<PostLaporEvent>(_onPostLaporEvent);
    on<GetLaporEvent>(_onGetLaporEvent);
  }

  final PostLapor laporUsecase;
  final GetRiwayatLapor riwayatUsecase;


  _onPostLaporEvent(
    PostLaporEvent event,
    Emitter<LaporState> emit
  ) async {
    emit(LaporLoading());
    final result = await laporUsecase(
      LaporParams(
        namaPelaku: event.params.namaPelaku,
        tempatKejadian: event.params.tempatKejadian,
        tanggalKejadian: event.params.tanggalKejadian,
        hubungan: event.params.hubungan,
        uraian: event.params.uraian,
        isAnon: event.params.isAnon,
        authId: event.params.authId,
        sekoalhId: event.params.sekoalhId,
        status: 'SUBMITED'
      )
    );
    result!.fold(
      (l) => emit(LaporFailed(message: mapFailureToMessage(l))), 
      (r) => emit(LaporSuccess())
    );
  }

  _onGetLaporEvent(
    GetLaporEvent event,
    Emitter<LaporState> emit
  ) async {
    emit(LaporLoading());
    final result = await riwayatUsecase(RiwayatLaporParams(authId: event.auhtId));
    result!.fold(
      (l) => emit(LaporFailed(message: mapFailureToMessage(l))), 
      (r) => emit(LaporLoaded(lapor: r))
    );
  }
}
