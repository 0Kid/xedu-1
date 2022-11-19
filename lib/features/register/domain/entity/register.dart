import 'package:equatable/equatable.dart';

class Register extends Equatable {
  final String email;
  final String namaLengkap;
  final int umur;
  final String alamat;
  final String noTelp;
  final int sekolahId;
  final String jenisKelamin;
  final String password;

  const Register({
    required this.email, 
    required this.namaLengkap, 
    required this.umur, 
    required this.alamat, 
    required this.noTelp, 
    required this.sekolahId, 
    required this.jenisKelamin, 
    required this.password
  });


  @override
  List<Object?> get props => [
    email,
    namaLengkap,
    umur, 
    alamat,
    noTelp,
    sekolahId,
    jenisKelamin,
    password
  ];
  
}