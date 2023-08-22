part of 'settings_cubit.dart';

final class SettingsState {
  final bool isDarkModeEnabled;

  ThemeMode get themeMode =>
      isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light;

  const SettingsState({
    required this.isDarkModeEnabled,
  });

  SettingsState copyWith({
    bool? isDarkModeEnabled,
  }) {
    return SettingsState(
      isDarkModeEnabled: isDarkModeEnabled ?? this.isDarkModeEnabled,
    );
  }
}
