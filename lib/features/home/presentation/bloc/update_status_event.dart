part of 'update_status_bloc.dart';

abstract class UpdateStatusEvent extends Equatable {
  const UpdateStatusEvent();

  @override
  List<Object> get props => [];
}

class UpdateStatusPatchEvent extends UpdateStatusEvent {
  final String laporId;
  final String status;

  const UpdateStatusPatchEvent({required this.laporId, required this.status});

}
