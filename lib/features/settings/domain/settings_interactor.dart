import 'package:flutter/material.dart';

/// Интерактор для работы с настройками.
class SettingsInteractor {
  bool get isDarkModeEnabled => _themeMode == ThemeMode.dark;

  // TODO(ivanovdale): Пока что хранится здесь, потом подключим репозиторий.
  /// Тема приложения по умолчанию.
  ThemeMode _themeMode = ThemeMode.light;

  void changeAppTheme() {
    _themeMode = isDarkModeEnabled ? ThemeMode.light : ThemeMode.dark;
  }
}
