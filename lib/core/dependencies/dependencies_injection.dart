import '../../global_imports.dart';
import '../session/session_manager.dart';
import '../session/session_reader.dart';
import '../session/session_store.dart';
import '../session/secure_session_store.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  if (getIt.isRegistered<AppServices>()) {
    return;
  }

  //======================== Services ===============================================

  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());

  // Session restoration finishes before headers or UI can access credentials.
  getIt.registerSingleton<SessionStore>(
    SecureSessionStore(getIt<FlutterSecureStorage>()),
  );
  final session = SessionManager(
    getIt<SessionStore>(),
    clearCache: () async {
      await getIt<Box>(instanceName: BoxKey.cacheBox).clear();
    },
  );
  await session.initialize();
  getIt.registerSingleton<SessionManager>(
    session,
    dispose: (value) => value.dispose(),
  );
  getIt.registerSingleton<SessionReader>(session);

  //======================== Token ============================================
  getIt.registerFactory<TokenCubit>(
    () => TokenCubit(getIt<SessionManager>(), getIt<FlutterSecureStorage>()),
  );

  //======================== App Settings =====================================
  getIt.registerFactory<SettingsCubit>(SettingsCubit.new);

  //======================== Headers Provider ==================================
  getIt.registerLazySingleton<HeadersProvider>(
    () => HeadersProvider(
      hive: getIt<Box>(instanceName: BoxKey.appBox),
      session: getIt<SessionReader>(),
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
  getIt.registerFactory(() => ConnectionCubit(getIt<NetworkInfo>()));

  getIt.registerLazySingleton<AppServices>(AppServices.new);

  //======================== Features =========================================
}
