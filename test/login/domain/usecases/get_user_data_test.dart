import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/login/domain/entity/user.dart';
import 'package:xedu/features/login/domain/repositories/login_repository.dart';
import 'package:xedu/features/login/domain/usecases/get_user_data.dart';
import 'package:xedu/features/register/domain/entity/sekolah.dart';

class MockGetUserData extends Mock implements LoginRepository {}

void main() {
  late GetUserData usecase;
  late MockGetUserData mockGetUserData;

  setUp((){
    mockGetUserData = MockGetUserData();
    usecase = GetUserData(mockGetUserData);
  });

  const tEmail = 'budi@gmail.com';
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

  test('should get userdata from repository', () async {
    //arrange
    when(() => mockGetUserData.getUserData())
        .thenAnswer((_) async => const Right(tUser));

    //act
    final result = await usecase(NoParams());

    //assert
    expect(result, const Right<dynamic, UserData>(tUser));
    verify(() => mockGetUserData.getUserData());
  });  
}
