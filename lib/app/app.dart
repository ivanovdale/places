import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:places/helpers/app_router.dart';
import 'package:places/providers/settings_interactor_provider.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    // Локализация форматирования даты в приложении.
    initializeDateFormatting('ru', '');

    return MaterialApp(
      initialRoute: AppRouter.root,
      onGenerateRoute: AppRouter.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: context
          .watch<SettingsInteractorProvider>()
          .settingsInteractor
          .appTheme,
    );
  }
}
