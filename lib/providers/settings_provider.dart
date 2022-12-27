import 'package:flutter/material.dart';
import 'package:places/data/interactor/settings_interactor.dart';

/// Провайдер для интерактора для работы с настройками.
class SettingsInteractorProvider extends ChangeNotifier {
  final SettingsInteractor settingsInteractor;

  SettingsInteractorProvider(this.settingsInteractor);

  void changeAppTheme() {
    settingsInteractor.changeAppTheme();

    notifyListeners();
  }
}
