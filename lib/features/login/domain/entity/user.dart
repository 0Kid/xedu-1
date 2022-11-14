import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:xedu/features/register/domain/entity/sekolah.dart';

@HiveType(typeId: 1)
class UserData extends Equatable {
  const UserData({
    required this.data,
    required this.token
  });

  @HiveField(0)
  final User data;
  @HiveField(1)
  final String token;
  
  @override
  List<Object?> get props => [data, token]; 
}

@HiveType(typeId: 2)
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

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String namaLengkap;
  @HiveField(3)
  final String alamat;
  @HiveField(4)
  final String notelp;
  @HiveField(5)
  final String jenisKelamin;
  @HiveField(6)
  final int sekolahId;
  @HiveField(7)
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
