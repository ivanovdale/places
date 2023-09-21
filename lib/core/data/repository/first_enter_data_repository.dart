import 'dart:async';

import 'package:places/core/domain/repository/first_enter_repository.dart';
import 'package:places/core/domain/source/storage/key_value_storage.dart';
import 'package:places/core/helpers/key_value_storage_keys.dart';

final class FirstEnterDataRepository implements FirstEnterRepository {
  final KeyValueStorage _keyValueStorage;

  @override
  FutureOr<bool> get isFirstEnter async =>
      (await _keyValueStorage.getBool(KeyValueStorageKeys.isFirstEnter)) ?? true;

  const FirstEnterDataRepository({
    required KeyValueStorage keyValueStorage,
  }) : _keyValueStorage = keyValueStorage;

  @override
  FutureOr<bool> saveFirstEnter() => _keyValueStorage.setBool(
        KeyValueStorageKeys.isFirstEnter,
        false,
      );
}
