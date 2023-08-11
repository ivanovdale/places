import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/features/settings/domain/settings_interactor.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsInteractor settingsInteractor;

  bool get _isDarkModeEnabled => settingsInteractor.isDarkModeEnabled;

  SettingsCubit(this.settingsInteractor)
      : super(
          SettingsState(
            isDarkModeEnabled: settingsInteractor.isDarkModeEnabled,
          ),
        );

  void changeAppTheme() {
    settingsInteractor.changeAppTheme();

    emit(
      SettingsState(
        isDarkModeEnabled: _isDarkModeEnabled,
      ),
    );
  }
}
