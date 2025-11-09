import '../../../../global_imports.dart';

final getIt = GetIt.instance;

void initGetIt() async {
  //======================== Dio ===============================================
  getIt.registerSingleton<AppServices>(AppServices());
  final appBox = await Hive.openBox(BoxKey.appBox);
  getIt.registerSingleton<Box>(appBox, instanceName: BoxKey.appBox);
  //======================== Services ==========================================
  getIt.registerLazySingleton<HeadersProvider>(
        () => HeadersProvider(hive: getIt<Box>(instanceName: BoxKey.appBox)),
  );
  getIt.registerSingleton<ApiServices>(ApiServices(Dio()));

  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(Connectivity()));
  getIt.registerLazySingleton(() => ConnectionCubit(getIt<NetworkInfo>()));

  //======================== Hive Boxes ========================================

  AndroidOptions getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
  getIt.registerSingleton<FlutterSecureStorage>(
    FlutterSecureStorage(aOptions: getAndroidOptions()),
  );

  //======================== Features  =========================================

  initAuthDI();
}
