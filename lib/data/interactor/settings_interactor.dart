import 'package:flutter/material.dart';
import 'package:places/UI/screens/res/themes.dart';

/// Интерактор для работы с настройками.
class SettingsInteractor {

  /// Тема приложения по умолчанию.
  ThemeData appTheme = lightTheme;

  bool isDarkModeEnabled = false;

  void changeAppTheme() {
    isDarkModeEnabled = !isDarkModeEnabled;
    appTheme = isDarkModeEnabled ? darkTheme : lightTheme;
  }

}
