import 'dart:async';

import 'package:places/core/helpers/shared_prefs_keys.dart';
import 'package:places/features/settings/domain/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SettingsSharedPreferencesRepository implements SettingsRepository {
  final SharedPreferences _sharedPreferences;

  @override
  FutureOr<bool> get isDarkModeEnabled async =>
      _sharedPreferences.getBool(SharedPrefsKeys.isDarkModeEnabled) ?? false;

  const SettingsSharedPreferencesRepository({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  @override
  Future<bool> changeAppTheme() async {
    return _sharedPreferences.setBool(
        SharedPrefsKeys.isDarkModeEnabled, !(await isDarkModeEnabled));
  }
}
