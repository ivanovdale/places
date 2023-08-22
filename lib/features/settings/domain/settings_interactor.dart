import 'dart:async';

import 'package:places/features/settings/domain/settings_repository.dart';

/// Интерактор для работы с настройками.
class SettingsInteractor {
  final SettingsRepository _settingsRepository;

  FutureOr<bool> get isDarkModeEnabled => _settingsRepository.isDarkModeEnabled;

  SettingsInteractor({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  Future<bool> changeAppTheme() => _settingsRepository.changeAppTheme();
}
