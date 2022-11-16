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

  Map<String, dynamic> toJson() => {
    "data": {
      "id": data.id,
      "email": data.email,
      "nama_lengkap": data.namaLengkap,
      "alamat": data.alamat,
      "notelp": data.notelp,
      "jenis_kelamin": data.jenisKelamin,
      "sekolahId": data.sekolahId,
      "sekolah": {
        "id": data.sekolah?.id,
        "nama_sekolah": data.sekolah?.namaSekolah
      },
    },
    "token": token
  };
}

class UserModel extends User {
  UserModel({required super.id, required super.email, required super.namaLengkap, required super.alamat, required super.notelp, required super.jenisKelamin, required super.sekolahId, required super.sekolah});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] == null ? null : json["id"],
      email: json["email"] == null ? null : json["email"],
      namaLengkap: json["nama_lengkap"] == null ? null : json["nama_lengkap"],
      alamat: json["alamat"] == null ? null : json["alamat"],
      notelp: json["notelp"] == null ? null : json["notelp"],
      jenisKelamin: json["jenis_kelamin"] == null ? null : json["jenis_kelamin"],
      sekolahId: json["sekolahId"] == null ? null : json["sekolahId"],
      sekolah: json["sekolah"] == null ? null : SekolahModel.fromJson(json["sekolah"]),
    );
  }
  
}
