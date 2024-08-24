import 'package:api_learn/cubit/my_cubit.dart';
import 'package:api_learn/my_repo.dart';
import 'package:api_learn/web_services.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initGet() {
  getIt.registerLazySingleton<MyCubit>(() => MyCubit(myRepo: getIt()));
  getIt.registerLazySingleton<MyRepo>(() => MyRepo(webServices: getIt()));
  getIt.registerLazySingleton<WebServices>(
      () => WebServices(createAndSetupDio()));
}

Dio createAndSetupDio() {
  Dio dio = Dio();

  dio.options.connectTimeout = const Duration(
    minutes: 1,
  );
  dio.options.receiveTimeout = const Duration(minutes: 1);

  dio.interceptors.add(LogInterceptor(
      responseBody: true,
      responseHeader: false,
      requestHeader: false,
      requestBody: true,
      request: true,
      error: true));

  return dio;
}
