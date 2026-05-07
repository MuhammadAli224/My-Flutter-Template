import '../../global_imports.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  if (getIt.isRegistered<AppServices>()) {
    return;
  }

  //======================== Services ===============================================
  getIt.registerLazySingleton<AppServices>(AppServices.new);

  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());

  //======================== Token ============================================
  getIt.registerFactory<TokenCubit>(
    () => TokenCubit(getIt<FlutterSecureStorage>()),
  );

  //======================== App Settings =====================================
  getIt.registerLazySingleton<SettingsCubit>(SettingsCubit.new);

  //======================== Headers Provider ==================================
  getIt.registerLazySingleton<HeadersProvider>(
    () => HeadersProvider(
      hive: getIt<Box>(instanceName: BoxKey.appBox),
      tokenCubit: getIt<TokenCubit>(),
    ),
  );

  //======================== Dio + Interceptors ================================
  final dio = Dio();
  final headersProvider = getIt<HeadersProvider>();

  dio.interceptors.add(HeaderInterceptor(headersProvider));
  dio.interceptors.add(DioInterceptor());

  getIt.registerLazySingleton<ApiServices>(
    () => ApiServices(dio, headersProvider),
  );
  //======================== Network ==========================================
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(Connectivity()),
  );
  getIt.registerLazySingleton(() => ConnectionCubit(getIt<NetworkInfo>()));

  //======================== Features =========================================
}
