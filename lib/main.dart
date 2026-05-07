import 'app.dart';
import 'global_imports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInitializer.init();

  runApp(
    EasyLocalization(
      supportedLocales: AppLocalization.supportedLocales,
      startLocale: AppLocalization.startLocale,
      fallbackLocale: AppLocalization.fallbackLocale,
      saveLocale: AppLocalization.saveLocale,
      path: AppLocalization.translationsPath,
      child: const MyApp(),
    ),
  );
}
