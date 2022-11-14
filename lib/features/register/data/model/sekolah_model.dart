import 'package:xedu/features/register/domain/entity/sekolah.dart';

class SekolahModel extends Sekolah {
  SekolahModel({required super.id, required super.namaSekolah});

  factory SekolahModel.fromJson(Map<String, dynamic> json) {
    return SekolahModel(
      id: json['id'], 
      namaSekolah: json['nama_sekolah']
    );
  }
  
}