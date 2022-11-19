import 'package:equatable/equatable.dart';

class Register extends Equatable {
  final int status;
  final String message;

  const Register({required this.status, required this.message});


  @override
  List<Object?> get props => [
    status,
    message
  ];
  
}