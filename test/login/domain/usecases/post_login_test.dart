import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/features/login/domain/entity/user.dart';
import 'package:xedu/features/login/domain/repositories/login_repository.dart';
import 'package:xedu/features/login/domain/usecases/post_login.dart';
import 'package:xedu/features/register/domain/entity/sekolah.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  PostLogin? usecase;
  MockLoginRepository? mockLoginRepository;

  setUp((){
    mockLoginRepository = MockLoginRepository();
    usecase = PostLogin(mockLoginRepository);
  });

  const tEmail = 'budi@gmail.com';
  const tPassword = 'bankong';
  const sekolah = Sekolah(id: 1, namaSekolah: 'smpn 3 jatiwangi');
  const tUserData = User(
    id: 1, 
    email: tEmail, 
    namaLengkap: 'budi doremi', 
    alamat: 'bandung', 
    notelp: '081324145108', 
    jenisKelamin: 'lelaki', 
    sekolahId: 1, 
    sekolah: sekolah, 
  );
  const tUser = UserData(data: tUserData, token: '1234');


  test('should get user data for the sign in user from the repository',
  () async {
    when(()=> mockLoginRepository?.postLogin(any(), any()))
      .thenAnswer((_) async => const Right(tUser));

    final result = await usecase!(const Params(email: tEmail, password: tPassword));

    expect(result, const Right<dynamic, UserData>(tUser));

    verify(()=>mockLoginRepository?.postLogin(tEmail, tPassword));

    verifyNoMoreInteractions(mockLoginRepository);
    
  });
}
