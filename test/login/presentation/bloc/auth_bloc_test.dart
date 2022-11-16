import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/login/data/model/user_model.dart';
import 'package:xedu/features/login/domain/usecases/get_user_data.dart';
import 'package:xedu/features/login/presentation/bloc/auth_bloc.dart';
import 'package:xedu/features/register/data/model/sekolah_model.dart';

class MockAuthBloc extends Mock implements GetUserData {}

void main() {
  late MockAuthBloc mockAuthBloc;
  late AuthBloc bloc;

  setUp((){
    mockAuthBloc = MockAuthBloc();
    bloc = AuthBloc(fetch: mockAuthBloc);
  });

  test('initial should be [AuthInitial]', () async {
    //assert
    expect(bloc.initislState, equals(AuthInitial()));
  });
  
  group('get data from local storage', () {
    const tEmail = 'ziamuhamad@gmail.com';
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
    test('should return user data from local data souce', () async {
      //arrange
      when(() => mockAuthBloc.call(NoParams())).thenAnswer((_) async => Right(tUser));
      //act
      bloc.add(CheckAuthEvent());
      await untilCalled(() => mockAuthBloc.call(NoParams()));
      //assert
      verify(() => mockAuthBloc.call(NoParams()));
    });
  });
}