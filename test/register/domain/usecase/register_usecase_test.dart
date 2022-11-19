import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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

  test('should post from register repository', () async {
    //arrange
    //act
    final result = await usecase(tParams);
    //assert
    verify(() => mockRegisterRepository.postRegistration(
      tParams
    ));
    expect(result, isA<Void>());
  });
}