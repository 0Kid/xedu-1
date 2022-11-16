  import 'package:xedu/core/error/failures.dart';
import 'package:xedu/features/login/presentation/bloc/login_bloc.dart';

String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'UnexpectedError';
    }
  }