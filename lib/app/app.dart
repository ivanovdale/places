import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/app/app_dependencies.dart';
import 'package:places/app/app_providers.dart';
import 'package:places/core/helpers/app_router.dart';
import 'package:places/core/presentation/res/themes.dart';
import 'package:places/features/settings/presentation/cubit/settings_cubit.dart';

class App extends StatefulWidget {
  AppDependencies get _appDependencies => AppDependencies.instance;

  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    widget._appDependencies.geolocationInteractor.requestPermission().ignore();
  }

  @override
  void dispose() {
    widget._appDependencies.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      appDependencies: widget._appDependencies,
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            initialRoute: AppRouter.root,
            onGenerateRoute: AppRouter.generateRoute,
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state.themeMode,
          );
        },
      ),
    );
  }
}
