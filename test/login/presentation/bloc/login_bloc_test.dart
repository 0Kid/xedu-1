import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:xedu/features/login/data/model/user_model.dart';
import 'package:xedu/features/login/domain/usecases/post_login.dart';
import 'package:xedu/features/login/presentation/bloc/login_bloc.dart';
import 'package:xedu/features/register/data/model/sekolah_model.dart';

class MockPostLogin extends Mock implements PostLogin {}
class MockPostLoginAdmin extends Mock implements PostLoginAdmin{}

void main() {
  late LoginBloc bloc;
  late MockPostLogin mockPostLogin;
  late MockPostLoginAdmin mockPostLoginAdmin;

  setUp((){
    mockPostLogin = MockPostLogin();
    mockPostLoginAdmin = MockPostLoginAdmin();
    bloc = LoginBloc(postLogin: mockPostLogin, postLoginAdmin: mockPostLoginAdmin);
  });

  test('initState should be LoginInitial', () {
    //assert
    expect(bloc.initialState, equals(LoginInitial()));
  });

  group('postLogin', () {
    const tEmail = 'ziamuhamad@gmail.com';
    const tPassword = 'zia123123';
    final tSekolah = SekolahModel(id: 1, namaSekolah: 'smpn 1 jatiwangi');
    final tUserData = UserModel(
      id: 1, 
      email: tEmail, 
      namaLengkap: 'budi', 
      alamat: 'bandung', 
      notelp: '1234', 
      jenisKelamin: 'lelaki', 
      sekolahId: 1, 
      sekolah: tSekolah, 
    );
    final tUser = UserDataModel(data: tUserData, token: '1234');
    
    test('should get data from concrete use case', () async {
      //arrange
      when(() => mockPostLogin(Params(email: tEmail, password: tPassword)))
        .thenAnswer((_) async => await Right(tUser));
      //act
      bloc.add(PostLoginEvent(email: tEmail, password: tPassword));
      await untilCalled(() => mockPostLogin(Params(email: tEmail, password: tPassword)));
      //assert
      verify(() => mockPostLogin(Params(email: tEmail, password: tPassword)));
    });

    test('should emit [LoginLoading, LoginSuccess] when succesfully login', () async* {
      //arrange
      when(() => mockPostLogin(Params(email: any(), password: any())))
        .thenAnswer((_) async => await Right(tUser));
      //assert later
      final expexted = [
        LoginInitial(),
        LoginLoading(),
        LoginSuccess(user: tUser)
      ];
      expectLater(bloc.state, emitsInOrder(expexted));
      //act
      bloc.add(PostLoginEvent(email: tEmail, password: tPassword));
      
    });

      test('should emit [LoginInitial, LoginLoading, LoadingFailed', () async* {
      //arrange
        when(() => mockPostLogin(Params(email: any(), password: any())))
          .thenAnswer((_) async => await Left(ServerFailure()));
      //assert later
      final expected = [
        LoginInitial(),
        LoginLoading(),
        LoginFailed(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.add(PostLoginEvent(email: tEmail, password: tPassword));
    });
  });
}