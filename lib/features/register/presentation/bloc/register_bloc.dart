import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xedu/core/error/map_error_to_message.dart';
import 'package:xedu/features/register/domain/usecase/register_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required this.usecase}) : super(RegisterInitial()) {
    on<PostRegistrationEvent>(_onRegistrationPostEvent);
  }

  final PostRegistration usecase;
  RegisterState get initialState => RegisterInitial();

  _onRegistrationPostEvent(
    PostRegistrationEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    final result = await usecase(
      RegisterParams(
        email: event.params.email,
        namaLengkap: event.params.namaLengkap,
        alamat: event.params.alamat,
        jenisKelamin: event.params.jenisKelamin,
        noTelp: event.params.noTelp,
        password: event.params.password,
        sekolahId: event.params.sekolahId,
        umur: event.params.umur
      )
    );
    result!.fold(
      (l) => emit(RegisterFailed(mapFailureToMessage(l))), 
      (r) => emit(RegisterSuccess())
    );
  }
}
