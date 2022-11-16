import 'package:equatable/equatable.dart';
import 'package:xedu/features/register/domain/entity/sekolah.dart';

class UserData extends Equatable {
  const UserData({
    required this.data,
    required this.token
  });

  final User data;
  final String token;
  
  @override
  List<Object?> get props => [data, token]; 
}

class User extends Equatable {
  const User({
    required this.id, 
    required this.email, 
    required this.namaLengkap, 
    required this.alamat, 
    required this.notelp, 
    required this.jenisKelamin, 
    required this.sekolahId, 
    required this.sekolah, 
  });

  final int id;
  final String email;
  final String namaLengkap;
  final String alamat;
  final String notelp;
  final String jenisKelamin;
  final int sekolahId;
  final Sekolah sekolah;

  @override
  List<Object?> get props => [
    id,
    email,
    namaLengkap,
    alamat,
    notelp,
    jenisKelamin,
    sekolahId,
    sekolah,
  ];
}
