import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/features/settings/domain/settings_interactor.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsInteractor _settingsInteractor;

  Future<bool> get _isDarkModeEnabled => _settingsInteractor.isDarkModeEnabled;

  SettingsCubit({
    required SettingsInteractor settingsInteractor,
  })  : _settingsInteractor = settingsInteractor,
        super(const SettingsState(isDarkModeEnabled: false));

  Future<void> initialize() async {
    emit(SettingsState(isDarkModeEnabled: await _isDarkModeEnabled));
  }

  Future<void> changeAppTheme() async {
    emit(SettingsState(isDarkModeEnabled: !state.isDarkModeEnabled));

    await _settingsInteractor.changeAppTheme();
  }
}
