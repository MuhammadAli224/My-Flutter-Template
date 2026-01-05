import '../../global_imports.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  //======================== Services ===============================================
  getIt.registerSingleton<AppServices>(AppServices());

  //======================== Local Storage =====================================
  final appBox = await Hive.openBox(BoxKey.appBox);
  getIt.registerSingleton<Box>(appBox, instanceName: BoxKey.appBox);

  AndroidOptions getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  getIt.registerSingleton<FlutterSecureStorage>(
    FlutterSecureStorage(aOptions: getAndroidOptions()),
  );

  //======================== Token ============================================
  getIt.registerLazySingleton<TokenCubit>(
    () => TokenCubit(getIt<FlutterSecureStorage>()),
  );

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

  getIt.registerSingleton<ApiServices>(ApiServices(dio, headersProvider));
  //======================== Network ==========================================
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(Connectivity()),
  );
  getIt.registerLazySingleton(() => ConnectionCubit(getIt<NetworkInfo>()));

  //======================== Features =========================================
  initAuthDI();
}
