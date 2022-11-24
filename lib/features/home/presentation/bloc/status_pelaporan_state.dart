part of 'status_pelaporan_bloc.dart';

abstract class StatusPelaporanState extends Equatable {
  const StatusPelaporanState();
  
  @override
  List<Object> get props => [];
}

class StatusPelaporanInitial extends StatusPelaporanState {}


class StatusPelaporanLaporLoading extends StatusPelaporanState {}

class StatusPelaporanLaporSuccess extends StatusPelaporanState {}

class StatusPelaporanLaporLoaded extends StatusPelaporanState {
  final Lapor lapor;

  const StatusPelaporanLaporLoaded({required this.lapor});
}

class StatusPelaporanLaporFailed extends StatusPelaporanState {
  final String message;

  const StatusPelaporanLaporFailed({required this.message});
}

