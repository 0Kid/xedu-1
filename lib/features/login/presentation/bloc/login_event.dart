part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PostLoginEvent extends LoginEvent {
  final String email;
  final String password;

  const PostLoginEvent({required this.email, required this.password});
}

class PostLoginAdminEvent extends LoginEvent {
  final String nohp;
  final String password;

  const PostLoginAdminEvent({required this.nohp, required this.password});
}
