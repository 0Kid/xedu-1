import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/platform/network_info.dart';

class MockInternetConnectioChecker extends Mock implements InternetConnectionChecker {}

void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnectioChecker mockInternetConnectioChecker;

  setUp((){
    mockInternetConnectioChecker = MockInternetConnectioChecker();
    networkInfoImpl = NetworkInfoImpl(mockInternetConnectioChecker);
  });

  group('isConnected', () {
    test('should forward the call to InternetConnectionChecker.hasConnection', () async {
      //arange
      final tHasConnectionFuture = Future.value(true);
      when(() => mockInternetConnectioChecker.hasConnection)
        .thenAnswer((_) => tHasConnectionFuture);
      //act
      final result = networkInfoImpl.isConnected;
      //assert
      verify(()=> mockInternetConnectioChecker.hasConnection);
      expect(result, tHasConnectionFuture);
    });
  });
}