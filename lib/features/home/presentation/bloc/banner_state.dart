part of 'banner_bloc.dart';

abstract class BannerState extends Equatable {
  const BannerState();
  
  @override
  List<Object> get props => [];
}

class BannerInitial extends BannerState {}

class BannerLoading extends BannerState {}

class BannerLoaded extends BannerState {
  final Banner banner;

  BannerLoaded({required this.banner});
}

class BannerFailed extends BannerState {
  final String message;

  BannerFailed(this.message);
}
