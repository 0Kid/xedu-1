part of 'status_pelaporan_bloc.dart';

abstract class StatusPelaporanEvent extends Equatable {
  const StatusPelaporanEvent();

  @override
  List<Object> get props => [];
}

class StatusPelaporanGetEvent extends StatusPelaporanEvent {
  final String sekolahId;

  const StatusPelaporanGetEvent({required this.sekolahId});
}
