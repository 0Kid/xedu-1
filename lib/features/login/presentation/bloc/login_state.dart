part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserData user;

  LoginSuccess({required this.user});
}

class LoginFailed extends LoginState {
  final String message;

  LoginFailed({required this.message});
}
