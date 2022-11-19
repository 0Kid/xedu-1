import 'package:xedu/features/register/data/model/register_model.dart';

abstract class RegisterRemoteDatasource {
  Future<RegisterModel>? remoteRegister(String email, String namaLengkap, int umur, String alamat, String noTelp, int sekolahId, String jenisKelamin, String password);
}