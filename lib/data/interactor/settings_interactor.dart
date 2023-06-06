import 'package:flutter/material.dart';

/// Интерактор для работы с настройками.
class SettingsInteractor {
  /// Тема приложения по умолчанию.
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkModeEnabled => themeMode == ThemeMode.dark;

  void changeAppTheme() {
    themeMode = isDarkModeEnabled ? ThemeMode.light : ThemeMode.dark;
  }
}
