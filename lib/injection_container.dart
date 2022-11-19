import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xedu/core/platform/network_info.dart';
import 'package:xedu/features/home/data/datasources/banner_local_datasource.dart';
import 'package:xedu/features/home/data/datasources/banner_remote_datasource.dart';
import 'package:xedu/features/home/data/datasources/news_local_datasource.dart';
import 'package:xedu/features/home/data/datasources/news_remote_datasource.dart';
import 'package:xedu/features/home/data/repositories/banner_repository_impl.dart';
import 'package:xedu/features/home/data/repositories/news_repository_impl.dart';
import 'package:xedu/features/home/domain/repositories/banner_repository.dart';
import 'package:xedu/features/home/domain/repositories/news_repository.dart';
import 'package:xedu/features/home/domain/usecases/banner_usecase.dart';
import 'package:xedu/features/home/domain/usecases/news_usecase.dart';
import 'package:xedu/features/home/presentation/bloc/banner_bloc.dart';
import 'package:xedu/features/home/presentation/bloc/news_bloc.dart';
import 'package:xedu/features/login/data/datasources/login_local_data_source.dart';
import 'package:xedu/features/login/data/datasources/login_remote_data_source.dart';
import 'package:xedu/features/login/data/repositories/login_repository_impl.dart';
import 'package:xedu/features/login/domain/repositories/login_repository.dart';
import 'package:xedu/features/login/domain/usecases/get_user_data.dart';
import 'package:xedu/features/login/domain/usecases/post_login.dart';
import 'package:xedu/features/login/presentation/bloc/auth_bloc.dart';
import 'package:xedu/features/login/presentation/bloc/login_bloc.dart';
import 'package:xedu/features/register/data/datasource/register_remote_datasource.dart';
import 'package:xedu/features/register/data/datasource/sekolah_remote_datasource.dart';
import 'package:xedu/features/register/data/repositories/register_repository_impl.dart';
import 'package:xedu/features/register/data/repositories/sekolah_repository_impl.dart';
import 'package:xedu/features/register/domain/repositories/register_repository.dart';
import 'package:xedu/features/register/domain/repositories/sekolah_repository.dart';
import 'package:xedu/features/register/domain/usecase/register_usecase.dart';
import 'package:xedu/features/register/domain/usecase/sekolah_usecase.dart';
import 'package:xedu/features/register/presentation/bloc/register_bloc.dart';
import 'package:xedu/features/register/presentation/bloc/sekolah_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //!Features
  //login
  //bloc
  sl.registerFactory(() => LoginBloc(postLogin: sl()));
  sl.registerFactory(() => AuthBloc(fetch: sl()));

  //Use Case
  sl.registerLazySingleton(() => PostLogin(sl()));
  sl.registerLazySingleton(() => GetUserData(sl()));

  //repository
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  
  //data source
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(client: sl())
  );
  sl.registerLazySingleton<LoginLocalDataSource>(
    ()=> LoginLocalDataSourceImpl(sharedPreferences: sl()) 
  );
  
    
  //home
  //bloc
  sl.registerFactory(() => BannerBloc(getBanner: sl()));
  sl.registerFactory(() => NewsBloc(usecase: sl()));

  //use case
  sl.registerLazySingleton(() => GetBanner(sl()));
  sl.registerLazySingleton(() => GetNews(repository: sl()));

  //repository
  sl.registerLazySingleton<BannerRepository>(
    () => BannerRepositoryImpl(
      localDataSource: sl(), 
      remoteDataSource: sl(), 
      networkInfo: sl()
      )
    );
    sl.registerLazySingleton<NewsRepository>(
      () => NewsRepositoryImpl(
        localDatasource: sl(), 
        remoteDatasource: sl(), 
        networkInfo: sl()
      )
    );

    //data source
  sl.registerLazySingleton<BannerRemoteDataSource>(() => BannerRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<BannerLocalDataSource>(()=> BannerLocalDataSourceImpl(prefs: sl()));
  sl.registerLazySingleton<NewsLocalDatasource>(() => NewsLocalDatasourceImpl(prefs: sl()));
  sl.registerLazySingleton<NewsRemoteDataSource>(() => NewsRemoteDataSourceImpl(client: sl()));

  //register
  //bloc
  sl.registerFactory(() => SekolahBloc(usecase: sl()));
  sl.registerFactory(() => RegisterBloc(usecase: sl()));

  //usecase
  sl.registerLazySingleton(() => GetSekolah(repository: sl()));
  sl.registerLazySingleton(() => PostRegistration(repository: sl()));

  //resosiotry
  sl.registerLazySingleton<SekolahRepository>(
    () => SekolahRepositoryImpl(
      remoteDatasource: sl(), 
      networkInfo: sl()
    )
  );
  sl.registerLazySingleton<RegisterRepository>(
    () => RegisterRepositoryImpl(
      datasource: sl(), 
      networkInfo: sl()
    )
  );

  //datasource
  sl.registerLazySingleton<SekolahRemoteDatasource>(
    () => SekolahRemoteDatasourceImpl(client: sl())
  );
  sl.registerLazySingleton<RegisterRemoteDatasource>(
    ()=> RegisterRemoteDatasourceImpl(client: sl())
  ); 


  //!Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));


  //!external
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}