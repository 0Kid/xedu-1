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

class SekolahDataModel extends SekolahData {
  SekolahDataModel({required super.sekolah});

  factory SekolahDataModel.fromJson(Map<String, dynamic> json ){
    return SekolahDataModel(
      sekolah: List<SekolahModel>.from(json['data'].map((x)=> SekolahModel.fromJson(x)))
    );
  }
}