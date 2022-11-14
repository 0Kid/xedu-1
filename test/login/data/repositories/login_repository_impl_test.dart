import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/core/error/failures.dart';
import 'package:xedu/core/platform/network_info.dart';
import 'package:xedu/features/login/data/datasources/login_local_data_source.dart';
import 'package:xedu/features/login/data/datasources/login_remote_data_source.dart';
import 'package:xedu/features/login/data/model/user_model.dart';
import 'package:xedu/features/login/data/repositories/login_repository_impl.dart';
import 'package:xedu/features/login/domain/entity/user.dart';
import 'package:xedu/features/register/data/model/sekolah_model.dart';

class MockRemoteDataSource extends Mock implements LoginRemoteDataSource {}
class MockLocalDataSource extends Mock implements LoginLocalDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late LoginRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp((){
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = LoginRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo
    );
  });

  group('postLogin', () {
    const tEmail = 'budi@gmail.com';
    const tPassword = 'bangkog';
    final tSekolah = SekolahModel(id: 1, namaSekolah: 'smpn 1 jatiwangi');
    final tUserModel = UserModel(
      id: 1, 
      email: tEmail, 
      namaLengkap: 'budi', 
      alamat: 'bandung', 
      notelp: '1234', 
      jenisKelamin: 'lelaki', 
      sekolahId: 1, 
      sekolah: tSekolah, 
    );
    final tUserDataModel = UserDataModel(data: tUserModel, token: '1234');
    final UserData tUserData = tUserDataModel;

    test('chould check if device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.postLogin(tEmail, tPassword);
      //assert
      verify(() => mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp((){
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return user data when logged in successfully', () async {
        //arrange
        when(()=> mockRemoteDataSource.auth(tEmail, tPassword))
          .thenAnswer((_) async => tUserDataModel);
        //act
        final result = await repository.postLogin(tEmail, tPassword);
        //assert
        verify(() => mockRemoteDataSource.auth(tEmail, tPassword));
        expect(result, equals(Right(tUserData)));
      });

     test('should return server failure whe the call to remote data source is unsuccesfull', () async {
       //arrange
       when(() => mockRemoteDataSource.auth(tEmail, tPassword))
        .thenThrow(ServerException());
      //act
      final result = await repository.postLogin(tEmail, tPassword);
      //assert
      verify(() => mockRemoteDataSource.auth(tEmail, tPassword));
      verifyZeroInteractions(mockLocalDataSource);
      expect(result, equals(Left(ServerFailure())));
     });
    });

    group('device is offline', () {
      setUp((){
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached user data ', () async {
        //arrange
        when(() => mockLocalDataSource.getUserDataFromLocal())
          .thenAnswer((_) async => tUserDataModel);
        //act
        final result = await repository.getUserData();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(()=>mockLocalDataSource.getUserDataFromLocal());
        expect(result, equals(Right(tUserData)));
      });

      test('should return CacheFailure when there is no cahced data', () async {
        //arrange
        when(() => mockLocalDataSource.getUserDataFromLocal())
          .thenThrow(CacheException());
        //act
        final result = await repository.getUserData();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.getUserDataFromLocal());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}