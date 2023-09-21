import 'dart:async';

import 'package:places/core/domain/source/storage/key_value_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SharedPreferencesStorage implements KeyValueStorage {
  final SharedPreferences _sharedPreferences;

  const SharedPreferencesStorage({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  @override
  bool? getBool(String key) => _sharedPreferences.getBool(key);

  @override
  double? getDouble(String key) => _sharedPreferences.getDouble(key);

  @override
  List<String>? getStringList(String key) =>
      _sharedPreferences.getStringList(key);

  @override
  Future<bool> setBool(String key, bool value) =>
      _sharedPreferences.setBool(key, value);

  @override
  Future<bool> setDouble(String key, double value) =>
      _sharedPreferences.setDouble(key, value);

  @override
  Future<bool> setStringList(String key, List<String> value) =>
      _sharedPreferences.setStringList(key, value);
}
