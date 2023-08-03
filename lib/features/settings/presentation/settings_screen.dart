import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/custom_app_bar.dart';
import 'package:places/UI/screens/components/custom_divider.dart';
import 'package:places/core/presentation/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:places/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:places/core/helpers/app_router.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:provider/provider.dart';

/// Экран настроек.
///
/// Отображает переключатель тёмной/светлой темы. Позволяет перейти на экран онбординга.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.settings,
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        centerTitle: true,
        toolbarHeight: 56,
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: const _SettingsBody(),
    );
  }
}

/// Содержит переключатель тёмной темы и кнопку для перехода на экран онбординга.
class _SettingsBody extends StatelessWidget {
  const _SettingsBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        top: 42.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Column(
        children: [
          _DarkModeSetting(),
          _DividerWithPaddingAndThickness(),
          _WatchTutorialInfo(),
          _DividerWithPaddingAndThickness(),
        ],
      ),
    );
  }
}

/// Кастомный разделитель с заданным отступом и толщиной.
class _DividerWithPaddingAndThickness extends StatelessWidget {
  const _DividerWithPaddingAndThickness({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomDivider(
      padding: EdgeInsets.only(
        top: 12,
        bottom: 14,
      ),
      thickness: 0.8,
    );
  }
}

/// Переключатель тёмной темы.
class _DarkModeSetting extends StatefulWidget {
  const _DarkModeSetting({Key? key}) : super(key: key);

  @override
  State<_DarkModeSetting> createState() => _DarkModeSettingState();
}

/// Хранит состояние переключателя тёмной темы.
class _DarkModeSettingState extends State<_DarkModeSetting> {
  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.read<SettingsCubit>();

    return Row(
      children: [
        Text(
          AppStrings.darkTheme,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Spacer(),
        CupertinoSwitch(
          value: settingsCubit.state.isDarkModeEnabled,
          onChanged: (newValue) => settingsCubit.changeAppTheme(),
        ),
      ],
    );
  }
}

/// Позволяет перейти на экран онбординга.
class _WatchTutorialInfo extends StatelessWidget {
  const _WatchTutorialInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Text(
          AppStrings.watchTutorial,
          style: theme.textTheme.bodyLarge,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
            icon: const Icon(Icons.info_outline),
            color: theme.colorScheme.primary,
            onPressed: () => goToOnboardingScreen(context),
          ),
        ),
      ],
    );
  }

  /// Выполняет переход на страницу онбординга.
  void goToOnboardingScreen(BuildContext context) {
    Navigator.pushNamed(context, AppRouter.onboarding);
  }
}
