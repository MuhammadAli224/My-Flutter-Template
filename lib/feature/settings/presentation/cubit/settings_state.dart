import '../../../../global_imports.dart';

class AppSettingsState {
  const AppSettingsState({this.themeMode = ThemeMode.light});

  final ThemeMode themeMode;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  AppSettingsState copyWith({ThemeMode? themeMode}) {
    return AppSettingsState(themeMode: themeMode ?? this.themeMode);
  }

  factory AppSettingsState.fromJson(Map<String, dynamic> json) {
    return AppSettingsState(
      themeMode: _themeModeFromName(json['themeMode'] as String?),
    );
  }

  Map<String, dynamic> toJson() {
    return {'themeMode': themeMode.name};
  }

  static ThemeMode _themeModeFromName(String? value) {
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == value,
      orElse: () => ThemeMode.light,
    );
  }
}
