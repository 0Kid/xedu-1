import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xedu/core/error/map_error_to_message.dart';
import 'package:xedu/features/login/domain/entity/user.dart';
import 'package:xedu/features/login/domain/usecases/post_login.dart';

part 'login_event.dart';
part 'login_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.postLogin,
    required this.postLoginAdmin
  }) : super(LoginInitial()) {
    on<PostLoginEvent>(_onPostLoginEvent);
    on<PostLoginAdminEvent>(_onPostLoginAdminEvent);
  }

  final PostLogin postLogin;
  final PostLoginAdmin postLoginAdmin;

  LoginState get initialState => LoginInitial();

  _onPostLoginEvent(
    PostLoginEvent event,
    Emitter<LoginState> emit
  ) async {
    emit(LoginLoading());
    final result = await postLogin.call(Params(email: event.email, password: event.password));
    result!.fold(
      (l) => emit(LoginFailed(message: mapFailureToMessage(l))), 
      (r) => emit(LoginSuccess(user: r))
    );
  }

  _onPostLoginAdminEvent(
    PostLoginAdminEvent event,
    Emitter<LoginState> emit
  ) async {
    emit(LoginLoading());
    final result = await postLoginAdmin.call(Params(email: event.nohp, password: event.password));
    result!.fold(
      (l) => emit(LoginFailed(message: mapFailureToMessage(l))), 
      (r) => emit(LoginSuccess(user: r))
    );
  }
}
