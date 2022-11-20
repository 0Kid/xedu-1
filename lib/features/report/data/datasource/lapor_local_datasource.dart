import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:xedu/core/error/exception.dart';
import 'package:xedu/features/report/data/model/lapor_model.dart';

const CACHED_LAPORAN = 'CACHED_LAPORAN';

abstract class LaporLocalDatasource {
  Future<LaporModel>? getLastRiwayatLapor();
  Future<void>? cachedRiwayatLapor(LaporModel laporModel);
}

class LaporLocalDatasourceImpl extends LaporLocalDatasource {
  final SharedPreferences prefs;

  LaporLocalDatasourceImpl({required this.prefs});
    
  @override
  Future<void>? cachedRiwayatLapor(LaporModel laporModel) {
    return prefs.setString(CACHED_LAPORAN, jsonEncode(laporModel));
  }

  @override
  Future<LaporModel>? getLastRiwayatLapor() {
    final lastLaporan = prefs.getString(CACHED_LAPORAN);
    if(lastLaporan != null){
      return Future.value(LaporModel.fromJson(jsonDecode(lastLaporan)));
    } else {
      throw ServerException();
    }
  }
  
}