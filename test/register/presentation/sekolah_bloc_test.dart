import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xedu/core/usecase/usecase.dart';
import 'package:xedu/features/login/presentation/bloc/login_bloc.dart';
import 'package:xedu/features/register/data/model/sekolah_model.dart';
import 'package:xedu/features/register/domain/usecase/sekolah_usecase.dart';
import 'package:xedu/features/register/presentation/bloc/sekolah_bloc.dart';

class MockGetSekolah extends Mock implements GetSekolah {}

void main() {
  late MockGetSekolah mockGetSekolah;
  late SekolahBloc bloc;

  setUp((){
    mockGetSekolah = MockGetSekolah();
    bloc = SekolahBloc(usecase: mockGetSekolah);
  });

  final tSekolahModel = SekolahModel(id: 1, namaSekolah: 'smpn 1 jatiwangi');
  final tSekolah = [tSekolahModel];
  final tSekolahDataModel = SekolahDataModel(sekolah: tSekolah);

  test('initial state should be SekolahInitial', () {
    expect(bloc.initialState, SekolahInitial());
  });

  test('should get sekolah data from sekolah usecase', () async {
    //arrange
    when(() => mockGetSekolah(NoParams())).thenAnswer((_) async => Right(tSekolahDataModel));
    //act
    bloc.add(GetSekolahEvent());
    await untilCalled(() => mockGetSekolah(NoParams()));
    //assert
    verify(() => mockGetSekolah(NoParams()));
  });

  test('should emit [SekolahInitial, SekolahLoading, SekolahLoaded]', () async* {
    //arrange
    when(() => mockGetSekolah(NoParams())).thenAnswer((_) async => Right(tSekolahDataModel));
    //assert later
    final expected = [
      SekolahInitial(),
      SekolahLoading(),
      SekolahLoaded(tSekolahDataModel)
    ];
    expectLater(bloc.state, emitsInOrder(expected));
    //act
    bloc.add(GetSekolahEvent());
  });

  test('should emit [SekolahInitial, SekolahLoading, SekolahFailed]', () async* {
    //arrange
    when(() => mockGetSekolah(NoParams())).thenAnswer((_) async => Right(tSekolahDataModel));
    //assert later
    final expected = [
      SekolahInitial(),
      SekolahLoading(),
      SekolahFailed(SERVER_FAILURE_MESSAGE)
    ];
    expectLater(bloc.state, emitsInOrder(expected));
    //act
    bloc.add(GetSekolahEvent());
  });
}