import 'dart:async';

import 'package:places/core/domain/repository/first_enter_repository.dart';
import 'package:places/core/helpers/shared_prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class FirstEnterSharedPreferencesRepository
    implements FirstEnterRepository {
  final SharedPreferences _sharedPreferences;

  @override
  FutureOr<bool> get isFirstEnter =>
      _sharedPreferences.getBool(SharedPrefsKeys.isFirstEnter) ?? true;

  const FirstEnterSharedPreferencesRepository({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  @override
  FutureOr<bool> saveFirstEnter() => _sharedPreferences.setBool(
        SharedPrefsKeys.isFirstEnter,
        false,
      );
}
