import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/domain/repository/place_repository.dart';
import 'package:places/helpers/app_router.dart';
import 'package:places/place_search/presentation/redux/place_search_state.dart';
import 'package:places/providers/bottom_bar_provider.dart';
import 'package:places/providers/place_interactor_provider.dart';
import 'package:places/providers/settings_interactor_provider.dart';
import 'package:places/providers/visiting_provider.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Локализация форматирования даты в приложении.
    initializeDateFormatting('ru', '');
    final reduxStore = GetIt.instance.get<Store<PlaceSearchState>>();

    return StoreProvider<PlaceSearchState>(
      store: reduxStore,
      child: AppProviders(
        child: Builder(
          builder: (context) {
            return MaterialApp(
              initialRoute: AppRouter.root,
              onGenerateRoute: AppRouter.generateRoute,
              debugShowCheckedModeBanner: false,
              theme: context
                  .watch<SettingsInteractorProvider>()
                  .settingsInteractor
                  .appTheme,
            );
          },
        ),
      ),
    );
  }
}

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final networkPlaceRepository = GetIt.instance.get<PlaceRepository>();

    return MultiProvider(
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
      child: child,
    );
  }
}
