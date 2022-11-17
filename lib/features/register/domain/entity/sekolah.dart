import 'package:equatable/equatable.dart';

class Sekolah extends Equatable{
  const Sekolah({
    required this.id, 
    required this.namaSekolah,
  });

  final int id;
  final String namaSekolah;

  @override
  List<Object?> get props => [id, namaSekolah];
  
}

class SekolahData extends Equatable {
  final List<Sekolah> sekolah;

  SekolahData({required this.sekolah});

  @override
  List<Object?> get props => [sekolah];
  
}