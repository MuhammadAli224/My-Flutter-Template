import '../../../global_imports.dart';

void initAuthDI() {
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(secureStorage: getIt(), box: getIt()));

  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      remote: getIt(), local: getIt(), networkInfo: getIt()));

  getIt.registerLazySingleton<AuthLogoutCase>(() => AuthLogoutCase(getIt()));
  getIt.registerLazySingleton<AuthGetUserCase>(() => AuthGetUserCase(getIt()));
  getIt.registerLazySingleton<AuthLoginCase>(() => AuthLoginCase(getIt()));
  getIt
      .registerLazySingleton<AuthRegisterCase>(() => AuthRegisterCase(getIt()));
  getIt.registerLazySingleton<AuthUpdateProfileCase>(
      () => AuthUpdateProfileCase(getIt()));

  getIt.registerFactory(() => AuthCubit(
        loginCase: getIt(),
        logoutCase: getIt(),
        registerCase: getIt(),
        getUserCase: getIt(),
        // updateProfileCase: getIt(),
      ));
}
