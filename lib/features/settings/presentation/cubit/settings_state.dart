part of 'settings_cubit.dart';

final class SettingsState {
  final bool isDarkModeEnabled;

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
