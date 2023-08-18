import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:qutes_app/Core/api/api_consumer.dart';
import 'package:qutes_app/Core/api/app_interceptors.dart';
import 'package:qutes_app/Core/api/dio_consumer.dart';
import 'package:qutes_app/Core/network/network_info.dart';
import 'package:qutes_app/features/random_quote/data/datasources/local_data_sourse.dart';
import 'package:qutes_app/features/random_quote/data/datasources/remote_data_sourse.dart';
import 'package:qutes_app/features/random_quote/data/repositories/quote_repositery_imp.dart';
import 'package:qutes_app/features/random_quote/domain/repositories/quote_repositery.dart';
import 'package:qutes_app/features/random_quote/domain/usecases/get_random_quote.dart';
import 'package:qutes_app/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:qutes_app/features/splash/data/datasources/lang_local_data_source.dart';
import 'package:qutes_app/features/splash/data/repositories/lang_repository_impl.dart';
import 'package:qutes_app/features/splash/domain/repositories/lang_repository.dart';
import 'package:qutes_app/features/splash/domain/usecases/change_lang.dart';
import 'package:qutes_app/features/splash/domain/usecases/get_save_lang.dart';
import 'package:qutes_app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features

  //* Blocs
  sl.registerFactory(() => RandomQuoteCubit(getRandomQuoteUserCase: sl()));
  sl.registerFactory<LocaleCubit>(
      () => LocaleCubit(getSavedLangUseCase: sl(), changeLangUseCase: sl()));

  //* Use cases
  sl.registerLazySingleton(() => GetRandomQuote(quoteRepository: sl()));
  sl.registerLazySingleton<GetSavedLangUseCase>(
      () => GetSavedLangUseCase(langRepository: sl()));
  sl.registerLazySingleton<ChangeLangUseCase>(
      () => ChangeLangUseCase(langRepository: sl()));

  //* Repository
  sl.registerLazySingleton<QuoteRepository>(() => QuoteRepositeryImp(
        localDataSourse: sl(),
        remoteDataSourse: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<LangRepository>(
      () => LangRepositoryImpl(langLocalDataSource: sl()));

  //* Data Sources
  sl.registerLazySingleton<LocalDataSourse>(
      () => LocalDataSourseImp(sharedPreferences: sl()));
  sl.registerLazySingleton<RemoteDataSourse>(
      () => RemoteDataSourseImp(apiConsumer: sl()));
  sl.registerLazySingleton<LangLocalDataSource>(
      () => LangLocalDataSourceImpl(sharedPreferences: sl()));

  //! core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => AppIntercepters());
  sl.registerLazySingleton(() => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
}
