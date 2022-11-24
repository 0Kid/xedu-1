part of 'update_status_bloc.dart';

abstract class UpdateStatusState extends Equatable {
  const UpdateStatusState();
  
  @override
  List<Object> get props => [];
}

class UpdateStatusInitial extends UpdateStatusState {}

class UpdateStatusLoading extends UpdateStatusState {}

class UpdateStatusSuccess extends UpdateStatusState {
  final UpdateStatus laporData;

  const UpdateStatusSuccess({required this.laporData});
}

class UpdateStatusFailed extends UpdateStatusState {
  final String message;

  const UpdateStatusFailed({required this.message});
}
