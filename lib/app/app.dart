import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/app/app_dependencies.dart';
import 'package:places/app/app_providers.dart';
import 'package:places/core/helpers/app_router.dart';
import 'package:places/core/presentation/res/themes.dart';
import 'package:places/features/settings/presentation/cubit/settings_cubit.dart';

class App extends StatelessWidget {
  final AppDependencies _appDependencies;

  const App({
    super.key,
    required AppDependencies appDependencies,
  }) : _appDependencies = appDependencies;

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      appDependencies: _appDependencies,
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            initialRoute: AppRouter.root,
            onGenerateRoute: AppRouter.generateRoute,
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                state.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }
}
