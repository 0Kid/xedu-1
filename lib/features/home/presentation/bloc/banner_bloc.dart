import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/home/domain/entity/banner.dart';
import 'package:xedu/features/home/domain/usecases/banner_usecase.dart';
import 'package:xedu/features/login/presentation/bloc/login_bloc.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc({required this.getBanner}) : super(BannerInitial()) {
    on<getBannerEvent>(_onGetBannerEvent);
  }

  final GetBanner getBanner;

  BannerState get initialState => BannerInitial();

  _onGetBannerEvent(
    getBannerEvent event,
    Emitter<BannerState> emit
  ) async {
    emit(BannerLoading());
    final result = await getBanner(NoParams());
    result!.fold(
      (l) => emit(BannerFailed(SERVER_FAILURE_MESSAGE)), 
      (r) => emit(BannerLoaded(banner: r))
    );
  }
}
