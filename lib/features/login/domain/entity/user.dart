import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.name, this.phoneNumber, this.school);

  final String name;
  final int phoneNumber;
  final String school;
  
  @override
  List<Object?> get props => [name, phoneNumber, school]; 
}