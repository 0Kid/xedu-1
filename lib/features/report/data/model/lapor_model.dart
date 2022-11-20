import 'package:xedu/features/report/domain/entity/lapor.dart';

class LaporModel extends Lapor {
  const LaporModel({required super.lapor});

  factory LaporModel.fromJson(Map<String, dynamic> json){
    return LaporModel(
      lapor: List<LaporDataModel>.from(json["data"].map((x)=> LaporDataModel.fromJson(x)))
    );
  }

  Map<String, dynamic> toJson() => {
    'data': List<dynamic>.from(lapor.map((e) => e.toJson()))
  };
}

class LaporDataModel extends LaporData {
  const LaporDataModel({required super.id, required super.namaPelaku, required super.tempatKejadian, required super.tanggalKejadian, required super.hubungan, required super.uraian, required super.isAnon, required super.status, required super.createdAt, required super.authId, required super.sekoalhId});
  
  factory LaporDataModel.fromJson(Map<String, dynamic> json) {
    return LaporDataModel(
      id: json['id'], 
      namaPelaku: json['nama_pelaku'], 
      tempatKejadian: json['tempat_kejadian'], 
      tanggalKejadian: json['tanggal_kejadian'], 
      hubungan: json['hubungan'], 
      uraian: json['uraian'], 
      isAnon: json['isAnonym'], 
      status: json['status'], 
      createdAt: DateTime.parse(json['createdAt']), 
      authId: json['authId'], 
      sekoalhId: json['sekolahId']
    );
  }
}