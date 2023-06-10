import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:places/API/dio_api.dart';
import 'package:places/app/app.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/repository/network_place_repository.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/favourite_places/data/favourite_place_data_repository.dart';
import 'package:places/favourite_places/data/favourite_place_interactor.dart';
import 'package:places/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_bloc.dart';
import 'package:places/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_event.dart';
import 'package:places/providers/bottom_bar_provider.dart';
import 'package:places/providers/place_interactor_provider.dart';
import 'package:places/providers/settings_interactor_provider.dart';
import 'package:provider/provider.dart';

void main() {
  final networkPlaceRepository = NetworkPlaceRepository(DioApi());
  final favouritePlaceDataRepository = FavouritePlaceDataRepository();
  GetIt.instance.registerSingleton<PlaceRepository>(networkPlaceRepository);

  runApp(
    BlocProvider(
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
            create: (context) =>
                SettingsInteractorProvider(SettingsInteractor()),
          ),
        ],
        child: const App(),
      ),
    ),
  );
}
