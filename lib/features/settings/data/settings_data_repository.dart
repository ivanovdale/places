import 'dart:async';

import 'package:places/core/domain/source/storage/key_value_storage.dart';
import 'package:places/core/helpers/key_value_storage_keys.dart';
import 'package:places/features/settings/domain/settings_repository.dart';

final class SettingsDataRepository implements SettingsRepository {
  final KeyValueStorage _keyValueStorage;

  @override
  FutureOr<bool> get isDarkModeEnabled async =>
      (await _keyValueStorage.getBool(KeyValueStorageKeys.isDarkModeEnabled)) ??
      false;

  const SettingsDataRepository({
    required KeyValueStorage keyValueStorage,
  }) : _keyValueStorage = keyValueStorage;

  @override
  Future<bool> changeAppTheme() async => _keyValueStorage.setBool(
      KeyValueStorageKeys.isDarkModeEnabled, !(await isDarkModeEnabled));
}
