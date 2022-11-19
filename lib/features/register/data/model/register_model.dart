import 'package:xedu/features/register/domain/entity/register.dart';

class RegisterModel extends Register {
  const RegisterModel({required super.status, required super.message});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      status: json['status'],
      message: json['message']
    );
  }
  
}