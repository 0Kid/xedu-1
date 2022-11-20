part of 'lapor_bloc.dart';

abstract class LaporState extends Equatable {
  const LaporState();
  
  @override
  List<Object> get props => [];
}

class LaporInitial extends LaporState {}

class LaporLoading extends LaporState {}

class LaporSuccess extends LaporState {}

class LaporLoaded extends LaporState {
  final Lapor lapor;

  const LaporLoaded({required this.lapor});
}

class LaporFailed extends LaporState {
  final String message;

  const LaporFailed({required this.message});
}
