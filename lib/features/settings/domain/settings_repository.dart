import 'dart:async';

abstract interface class SettingsRepository {
  Future<bool> changeAppTheme();

  FutureOr<bool> get isDarkModeEnabled;
}
