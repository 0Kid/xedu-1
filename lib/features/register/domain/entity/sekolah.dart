import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

@HiveType(typeId: 3)
class Sekolah extends Equatable{
  const Sekolah({
    required this.id, 
    required this.namaSekolah,
  });
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String namaSekolah;

  @override
  List<Object?> get props => [id, namaSekolah];
  
}