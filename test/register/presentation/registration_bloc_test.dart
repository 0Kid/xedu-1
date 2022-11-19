import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/features/login/presentation/bloc/login_bloc.dart';
import 'package:xedu/features/register/data/model/register_model.dart';
import 'package:xedu/features/register/domain/entity/register.dart';
import 'package:xedu/features/register/domain/usecase/register_usecase.dart';
import 'package:xedu/features/register/presentation/bloc/register_bloc.dart';

class MockPostRegsitration extends Mock implements PostRegistration {}

void main() {
  late MockPostRegsitration mockUsecase;
  late RegisterBloc bloc;

  setUp((){
    mockUsecase = MockPostRegsitration();
    bloc = RegisterBloc(usecase: mockUsecase);
  });

    final tParams = RegisterParams(
      email: 'budi@gmail.com', 
      namaLengkap: 'budi', 
      umur: 22, 
      alamat: 'bandung', 
      noTelp: '1', 
      sekolahId: 1, 
      jenisKelamin: 'pria', 
      password: 'bangkong'
    );
    final tRegisterModel = RegisterModel(
      status: 200,
      message: 'Success'
    );
    Register tRegister  = tRegisterModel;

  test('initial state should be RegisterInitial', () async {
    //act
    expect(bloc.initialState, equals(RegisterInitial()));
  });

  test('should post data to register usecase', () async {
    //arange
    when(() => mockUsecase(tParams)).thenAnswer((_) async => Right(tRegisterModel));
    //act
    bloc.add(PostRegistrationEvent(params: tParams));
    await untilCalled(() => mockUsecase(tParams));
    //assert
    verify(() => mockUsecase(tParams));
  });

  test('should emit [RegisterInitial, RegisterLoading, RegisterSuccess]', () async* {
    //arrange
    when(() => mockUsecase(tParams)).thenAnswer((_) async => Right(tRegisterModel));
    //assert later
    final expected = [
      RegisterInitial(),
      RegisterLoading(),
      RegisterSuccess()
    ];
    expectLater(bloc.state, emitsInOrder(expected));
    //act
    bloc.add(PostRegistrationEvent(params: tParams));
  });

  test('should emit [RegisterInitial, RegisterLoading, RegisterFailed]', () async* {
    //arrange
    when(() => mockUsecase(tParams)).thenAnswer((_) async => Right(tRegisterModel));
    //assert later
    final expected = [
      RegisterInitial(),
      RegisterLoading(),
      RegisterFailed(SERVER_FAILURE_MESSAGE)
    ];
    expectLater(bloc.state, emitsInOrder(expected));
    //act
    bloc.add(PostRegistrationEvent(params: tParams));
  });
}