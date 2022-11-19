import 'package:flutter_test/flutter_test.dart';
import 'package:xedu/features/register/data/model/register_model.dart';
import 'package:xedu/features/register/domain/entity/register.dart';


void main() {
  final tRegisterModel = RegisterModel(
    email: 'budi@gmail.com', 
    namaLengkap: 'budi', 
    umur: 22, 
    alamat: 'bandung', 
    noTelp: '1', 
    sekolahId: 1, 
    jenisKelamin: 'pria', 
    password: 'bangkong'
  );

  test('should be subclass of register', () {
    //assert
    expect(tRegisterModel, isA<Register>());
  });
}