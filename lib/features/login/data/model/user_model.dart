import 'package:xedu/features/login/domain/entity/user.dart';
import 'package:xedu/features/register/data/model/sekolah_model.dart';

class UserDataModel extends UserData {
  const UserDataModel({
    required super.data,
    required super.token
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      data: UserModel.fromJson(json['data']),
      token: json['token']
    );
  }
}

class UserModel extends User {
  UserModel({required super.id, required super.email, required super.namaLengkap, required super.alamat, required super.notelp, required super.jenisKelamin, required super.sekolahId, required super.sekolah});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'], 
      email: json['email'], 
      namaLengkap: json['nama_lengkap'], 
      alamat: json['alamat'], 
      notelp: json['notelp'], 
      jenisKelamin: json['jenis_kelamin'], 
      sekolahId: json['sekolahId'], 
      sekolah: SekolahModel.fromJson(json['sekolah']), 
    );
  }
  
}
