part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class PostRegistrationEvent extends RegisterEvent {
  final RegisterParams params;

  const PostRegistrationEvent({required this.params});
}
