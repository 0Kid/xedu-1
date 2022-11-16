part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PostLoginEvent extends LoginEvent {
  final String email;
  final String password;

  PostLoginEvent({required this.email, required this.password});
}
