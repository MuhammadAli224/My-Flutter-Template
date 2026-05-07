import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../../global_imports.dart' hide AppBlocObserver;
import '../bloc/observer/block_observer.dart';

class AppInitializer {
  AppInitializer._();

  static Future<void> init() async {
    await _initEnvironment();
    await _initLocalization();
    await _initHive();
    await _initHydratedBloc();
    await _initDependencyInjection();
    _initBlocObserver();
    await _initCoreServices();
    _configureErrorWidget();
  }

  static Future<void> _initEnvironment() async {
    await EnvConstant.init();
  }

  static Future<void> _initLocalization() async {
    await EasyLocalization.ensureInitialized();
  }

  static Future<void> _initHive() async {
    await HiveServices().init();
  }

  static Future<void> _initHydratedBloc() async {
    final storageDirectory = kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory(
            (await getApplicationDocumentsDirectory()).path,
          );

    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: storageDirectory,
    );
  }

  static Future<void> _initDependencyInjection() async {
    await initGetIt();
  }

  static void _initBlocObserver() {
    Bloc.observer = AppBlocObserver();
  }

  static Future<void> _initCoreServices() async {
    HttpOverrides.global = _AppHttpOverrides();
    await getIt<AppServices>().initAppServices();
  }

  static void _configureErrorWidget() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: AppColor.error, size: 56),
              16.gap,
              Text(LocaleKeys.unknownError.tr(), style: AppTextStyle.style18B),
              if (kDebugMode) ...[
                8.gap,
                Text(
                  details.exceptionAsString(),
                  style: AppTextStyle.style12.copyWith(color: AppColor.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      );
    };
  }
}

class _AppHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
