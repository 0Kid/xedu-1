import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xedu/core/platform/network_info.dart';
import 'package:xedu/features/login/data/datasources/login_local_data_source.dart';
import 'package:xedu/features/login/data/datasources/login_remote_data_source.dart';
import 'package:xedu/features/login/data/repositories/login_repository_impl.dart';
import 'package:xedu/features/login/domain/usecases/post_login.dart';
import 'package:xedu/features/login/presentation/bloc/login_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //!Features
  //login
  //bloc
  sl.registerFactory(
    () => LoginBloc(postLogin: sl())
  );

  //Use Case
  sl.registerLazySingleton(() => PostLogin(sl()));

  //repository
  sl.registerLazySingleton(() => LoginRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  
  //data source
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(client: sl())
  );
  sl.registerLazySingleton<LoginLocalDataSource>(
    ()=> LoginLocalDataSourceImpl(sharedPreferences: sl()) 
  );


  //!Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));


  //!external
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}