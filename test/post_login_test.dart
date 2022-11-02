import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:xedu/features/login/domain/entity/user.dart';
import 'package:xedu/features/login/domain/repositories/login_repository.dart';
import 'package:xedu/features/login/domain/usecases/post_login.dart';

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
  const tUser = User('budi', 081324145108, 'SMPN 3 Dayeuhkolot');

  test('should get user data for the sign in user from the repository',
  () async {
    when(mockLoginRepository?.postLogin(any, any))
      .thenAnswer((_) async => const Right(tUser));

    final result = await usecase!(const Params(email: tEmail, password: tPassword));

    expect(result, const Right<dynamic, User>(tUser));

    verify(mockLoginRepository?.postLogin(tEmail, tPassword));

    verifyNoMoreInteractions(mockLoginRepository);
    
  });
}
