import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:places/API/dio_api.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/repository/network_place_repository.dart';
import 'package:places/helpers/app_router.dart';
import 'package:places/providers/bottom_bar_provider.dart';
import 'package:places/providers/interactor_provider.dart';
import 'package:places/providers/settings_provider.dart';
import 'package:places/providers/visiting_provider.dart';
import 'package:provider/provider.dart';

void main() {
  final networkPlaceRepository = NetworkPlaceRepository(DioApi());
  GetIt.instance.registerSingleton(networkPlaceRepository);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlaceInteractorProvider(networkPlaceRepository),
        ),
        ChangeNotifierProvider(create: (context) => BottomBarProvider()),
        ChangeNotifierProvider(
          create: (context) => SettingsInteractorProvider(SettingsInteractor()),
        ),
        ChangeNotifierProxyProvider<PlaceInteractorProvider, VisitingProvider>(
          update: (context, interactor, previousMessages) =>
              VisitingProvider(interactor),
          create: (context) => VisitingProvider(null),
        ),
      ],
      child: const App(),
    ),
  );
}

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
