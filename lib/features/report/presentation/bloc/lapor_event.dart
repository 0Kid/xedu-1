part of 'lapor_bloc.dart';

abstract class LaporEvent extends Equatable {
  const LaporEvent();

  @override
  List<Object> get props => [];
}

class PostLaporEvent extends LaporEvent {
  final LaporParams params;

  const PostLaporEvent({required this.params});

}

class GetLaporEvent extends LaporEvent {
  final String auhtId;

  const GetLaporEvent({required this.auhtId});
}
