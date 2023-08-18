import 'package:places/features/settings/domain/settings_repository.dart';

/// Интерактор для работы с настройками.
class SettingsInteractor {
  final SettingsRepository _settingsRepository;

  Future<bool> get isDarkModeEnabled async =>
      _settingsRepository.isDarkModeEnabled;

  SettingsInteractor({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  Future<bool> changeAppTheme() async {
    return _settingsRepository.changeAppTheme();
  }
}
