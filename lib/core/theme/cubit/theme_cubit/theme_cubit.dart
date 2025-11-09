import '../../../../../../core/utils/theme.dart';
import '../../../../../../global_imports.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit._internal() : super(_lightTheme);
  static final ThemeCubit _instance = ThemeCubit._internal();

  factory ThemeCubit() {
    return _instance;
  }

  void init() {
    final bool isDarkMode = getIt<Box>(
      instanceName: BoxKey.appBox,
    ).get(BoxKey.isDarkMode, defaultValue: false);
    updateTheme(isDarkMode: isDarkMode);
  }

  static final ThemeData _lightTheme = ThemeData(
    colorScheme: MaterialTheme.lightScheme().copyWith(
      surface: const Color(0xFFE8E7E7),
      primary: MaterialTheme.lightScheme().primary,
      secondary: MaterialTheme.lightScheme().secondary,
      onSurface: Colors.black,
    ),
    useMaterial3: true,
    brightness: MaterialTheme.lightScheme().brightness,
    scaffoldBackgroundColor: MaterialTheme.lightScheme().surface,
    canvasColor: MaterialTheme.lightScheme().surface,
    appBarTheme: const AppBarTheme(centerTitle: true),
    fontFamily: 'Almarai',
  );

  static final ThemeData _darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: MaterialTheme.darkScheme().copyWith(
      surface: const Color(0xFF363636),
      // background: const Color(0xFF121212),
      primary: MaterialTheme.darkScheme().primary,
      secondary: MaterialTheme.darkScheme().secondary,
      onSurface: Colors.white,
    ),
    fontFamily: 'Almarai',
    scaffoldBackgroundColor: const Color(0xFF121212),
    canvasColor: const Color(0xFF1E1E1E),
    cardColor: const Color(0xFF242424),
    // cards and containers look elevated
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme().apply(
      displayColor: Colors.white,
      bodyColor: Colors.white,
      decorationColor: Colors.white,
    ),
    dividerColor: Colors.white24,
    shadowColor: Colors.black54,
  );

  void updateTheme({required bool isDarkMode}) {
    emit(isDarkMode ? _darkTheme : _lightTheme);

    getIt<Box>(instanceName: BoxKey.appBox).put(BoxKey.isDarkMode, isDarkMode);
  }

  bool get isDarkMode => state.brightness == Brightness.dark;
}
