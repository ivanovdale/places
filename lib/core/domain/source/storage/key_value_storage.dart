import 'dart:async';

abstract interface class KeyValueStorage {
  // ignore: avoid_positional_boolean_parameters
  FutureOr<bool> setBool(String key, bool value);

  FutureOr<bool> setDouble(String key, double value);

  FutureOr<bool> setStringList(String key, List<String> value);

  FutureOr<bool?> getBool(String key);

  FutureOr<double?> getDouble(String key);

  FutureOr<List<String>?> getStringList(String key);
}
