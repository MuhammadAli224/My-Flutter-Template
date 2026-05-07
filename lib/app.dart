import 'global_imports.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<SettingsCubit>()),
        BlocProvider(create: (_) => getIt<TokenCubit>()),
        BlocProvider(create: (_) => getIt<ConnectionCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return BlocBuilder<SettingsCubit, AppSettingsState>(
            builder: (context, settings) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: LocaleKeys.appName.tr(),
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: settings.themeMode,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                routerConfig: goRouters,
                scaffoldMessengerKey: GlobalContext.scaffoldMessengerKey,
              );
            },
          );
        },
      ),
    );
  }
}
