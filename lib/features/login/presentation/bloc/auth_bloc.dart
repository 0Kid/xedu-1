import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/login/domain/entity/user.dart';
import 'package:xedu/features/login/domain/usecases/get_user_data.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.fetch}) : super(AuthInitial()) {
    on<CheckAuthEvent>(_onAuthentication);
  }

  final GetUserData fetch;
  AuthState get initislState => AuthInitial();

  _onAuthentication(
    CheckAuthEvent event,
    Emitter<AuthState> emit
  ) async {
    final localData = await fetch(NoParams());
    localData?.fold(
      (l) => emit(Unauthorized()), 
      (r) => emit(Authorized(r))
    );
  }
}
