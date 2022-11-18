part of 'sekolah_bloc.dart';

abstract class SekolahState extends Equatable {
  const SekolahState();
  
  @override
  List<Object> get props => [];
}

class SekolahInitial extends SekolahState {}

class SekolahLoading extends SekolahState {}

class SekolahLoaded extends SekolahState {
  final SekolahData sekolahData;

  const SekolahLoaded(this.sekolahData);
}

class SekolahFailed extends SekolahState {
  final String message;

  const SekolahFailed(this.message);
}
