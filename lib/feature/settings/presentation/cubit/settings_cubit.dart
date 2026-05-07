import '../../../../global_imports.dart';

class SettingsCubit extends HydratedCubit<AppSettingsState> {
  SettingsCubit() : super(const AppSettingsState());

  @override
  String get storagePrefix => 'AppSettingsCubit';

  void setThemeMode(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }

  void updateTheme({required bool isDarkMode}) {
    setThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() {
    updateTheme(isDarkMode: !state.isDarkMode);
  }

  bool get isDarkMode => state.isDarkMode;

  @override
  AppSettingsState fromJson(Map<String, dynamic> json) {
    return AppSettingsState.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(AppSettingsState state) {
    return state.toJson();
  }
}
