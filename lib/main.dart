import 'core/services/token/token_cubit.dart';
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
  await EnvConstant.init();

  await HiveServices().init();

  await initGetIt();
  EasyLocalization.ensureInitialized();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Center(
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
    );
  };
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      startLocale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      saveLocale: true,
      path: 'assets/translations',
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()..init()),
        BlocProvider(create: (_) => getIt<TokenCubit>()),

        BlocProvider(create: (context) => getIt<ConnectionCubit>()),
      ],
      child: Builder(
        builder: (context) {
          final locale = context.locale;
          return ScreenUtilInit(
            builder: (_, child) {
              return BlocBuilder<ThemeCubit, ThemeData>(
                builder: (_, theme) {
                  return BlocBuilder<ConnectionCubit, ConnectionState>(
                    builder: (context, state) {
                      return MaterialApp.router(
                        debugShowCheckedModeBanner: false,
                        localizationsDelegates: context.localizationDelegates,
                        supportedLocales: context.supportedLocales,
                        locale: locale,
                        theme: theme,
                        routerConfig: goRouters,
                        scaffoldMessengerKey:
                            GlobalContext.scaffoldMessengerKey,
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
