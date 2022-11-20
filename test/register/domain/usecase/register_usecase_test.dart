import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/features/register/domain/entity/register.dart';
import 'package:xedu/features/register/domain/repositories/register_repository.dart';
import 'package:xedu/features/register/domain/usecase/register_usecase.dart';

class MockRegisterRepository extends Mock implements RegisterRepository {}

void main() {
  late MockRegisterRepository mockRegisterRepository;
  late PostRegistration usecase;

  setUp((){
    mockRegisterRepository = MockRegisterRepository();
    usecase = PostRegistration(repository: mockRegisterRepository);
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

  final tRegister = Register(status: 200, message: "Success");

  test('should post from register repository', () async {
    //arrange
    when(() => usecase(RegisterParams(
      email: tParams.email,
      namaLengkap: tParams.namaLengkap,
      umur: tParams.umur,
      alamat: tParams.alamat,
      noTelp: tParams.noTelp,
      sekolahId: tParams.sekolahId,
      jenisKelamin: tParams.jenisKelamin,
      password: tParams.password
    ))).thenAnswer((_) async => Right(tRegister));
    //act
    final result = await usecase(tParams);
    //assert
    verify(() => mockRegisterRepository.postRegistration(
      email: tParams.email,
      namaLengkap: tParams.namaLengkap,
      umur: tParams.umur,
      alamat: tParams.alamat,
      noTelp: tParams.noTelp,
      sekolahId: tParams.sekolahId,
      jenisKelamin: tParams.jenisKelamin,
      password: tParams.password
    ));
    expect(result, equals(Right(tRegister)));
  });
}