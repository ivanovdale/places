import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/API/dio_api.dart';
import 'package:places/UI/screens/res/themes.dart';
import 'package:places/data/interactor/place_search_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/repository/network_place_repository.dart';
import 'package:places/domain/repository/place_repository.dart';
import 'package:places/favourite_places/data/favourite_place_data_repository.dart';
import 'package:places/favourite_places/data/favourite_place_interactor.dart';
import 'package:places/favourite_places/domain/favourite_place_repository.dart';
import 'package:places/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_bloc.dart';
import 'package:places/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_event.dart';
import 'package:places/helpers/app_router.dart';
import 'package:places/place_search/presentation/redux/place_search_middleware.dart';
import 'package:places/place_search/presentation/redux/place_search_reducer.dart';
import 'package:places/place_search/presentation/redux/place_search_state.dart';
import 'package:places/providers/bottom_bar_provider.dart';
import 'package:places/providers/place_interactor_provider.dart';
import 'package:places/providers/settings_interactor_provider.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: Builder(
        builder: (context) {
          return MaterialApp(
            initialRoute: AppRouter.root,
            onGenerateRoute: AppRouter.generateRoute,
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: context
                .watch<SettingsInteractorProvider>()
                .settingsInteractor
                .themeMode,
          );
        },
      ),
    );
  }
}

class AppProviders extends StatelessWidget {
  late final FavouritePlaceRepository favouritePlaceDataRepository;
  late final PlaceRepository networkPlaceRepository;
  late final Store<PlaceSearchState> reduxStore;
  final Widget child;

  AppProviders({
    Key? key,
    required this.child,
  }) : super(key: key) {
    final networkPlaceRepository = NetworkPlaceRepository(DioApi());
    favouritePlaceDataRepository = FavouritePlaceDataRepository();
    this.networkPlaceRepository = networkPlaceRepository;
    reduxStore = _getReduxStore(networkPlaceRepository);
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<PlaceSearchState>(
      store: reduxStore,
      child: BlocProvider(
        create: (context) => FavouritePlacesBloc(
          FavouritePlaceInteractor(
            favouritePlaceDataRepository,
          ),
        )..add(
            FavoritePlacesInitEvent(),
          ),
        child: MultiProvider(
          providers: [
            Provider(
              create: (context) => PlaceInteractorProvider(
                placeRepository: networkPlaceRepository,
                favouritePlaceRepository: favouritePlaceDataRepository,
              ),
            ),
            ChangeNotifierProvider(create: (context) => BottomBarProvider()),
            ChangeNotifierProvider(
              create: (context) => SettingsInteractorProvider(
                SettingsInteractor(),
              ),
            ),
          ],
          child: child,
        ),
      ),
    );
  }
}

Store<PlaceSearchState> _getReduxStore(
  NetworkPlaceRepository networkPlaceRepository,
) {
  return Store<PlaceSearchState>(
    placesSearchReducers,
    initialState: PlaceSearchState.initial(),
    middleware: [
      PlaceSearchMiddleware(
        PlaceSearchInteractor(
          networkPlaceRepository,
        ),
      ),
    ],
  );
}
