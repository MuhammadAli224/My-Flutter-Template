import 'global_imports.dart';

var logger = Logger(printer: PrettyPrinter(colors: true, printEmojis: true));

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.ensureInitialized();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(title: const Text('Oops! An error occurred')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 80),
            20.gap,
            Text(AppStrings.unknownError.tr(), style: AppTextStyle.style18B),
            10.gap,
            Text(
              details.exceptionAsString(),
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  };
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('bn'),
        Locale('ur'),
      ],
      startLocale: const Locale('ar', "SA"),
      fallbackLocale: const Locale('en'),
      saveLocale: true,
      path: '/',
      assetLoader: CodeAssetLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(
            useMaterial3: true,
            appBarTheme: const AppBarTheme(centerTitle: true),
            fontFamily: 'Almarai',
          ),
          routerConfig: goRouters,
          scaffoldMessengerKey:GlobalContext.scaffoldMessengerKey,

        );
      },
    );
  }
}
