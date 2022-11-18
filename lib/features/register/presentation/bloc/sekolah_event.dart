part of 'sekolah_bloc.dart';

abstract class SekolahEvent extends Equatable {
  const SekolahEvent();

  @override
  List<Object> get props => [];
}

class GetSekolahEvent extends SekolahEvent {}