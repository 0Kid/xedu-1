import 'package:equatable/equatable.dart';

class Lapor extends Equatable {
  final List<LaporData> lapor;

  const Lapor({required this.lapor});

  @override
  List<Object?> get props => [lapor];
}

class LaporData extends Equatable {
  final int id;
  final String namaPelaku;
  final String tempatKejadian;
  final String tanggalKejadian;
  final String hubungan;
  final String uraian;
  final bool isAnon;
  final String status;
  final DateTime createdAt;
  final int authId;
  final int sekoalhId;

  const LaporData({
    required this.id, 
    required this.namaPelaku, 
    required this.tempatKejadian, 
    required this.tanggalKejadian, 
    required this.hubungan, 
    required this.uraian, 
    required this.isAnon, 
    required this.status,
    required this.createdAt, 
    required this.authId, 
    required this.sekoalhId
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'nama_pelaku': namaPelaku,
    'tempat_kejadian': tempatKejadian,
    'tanggal_kejadian': tanggalKejadian,
    'hubungan': hubungan,
    'uraian': uraian,
    'isAnonym': isAnon,
    'status': status,
    'createdAt': createdAt.toIso8601String(),
    'authId': authId,
    'sekolahId': sekoalhId
  };

  @override
  List<Object?> get props => [
    id,
    namaPelaku,
    tempatKejadian,
    tanggalKejadian,
    hubungan,
    uraian,
    isAnon,
    status,
    createdAt,
    authId,
    sekoalhId
  ];
  
}