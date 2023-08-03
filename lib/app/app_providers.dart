import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/API/dio_api.dart';
import 'package:places/data/repository/network_place_repository.dart';
import 'package:places/domain/repository/place_repository.dart';
import 'package:places/features/favourite_places/data/favourite_place_data_repository.dart';
import 'package:places/features/favourite_places/data/favourite_place_interactor.dart';
import 'package:places/features/favourite_places/domain/favourite_place_repository.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_bloc.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_event.dart';
import 'package:places/features/settings/domain/settings_interactor.dart';
import 'package:places/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:places/providers/bottom_bar_provider.dart';
import 'package:places/providers/place_interactor_provider.dart';
import 'package:provider/provider.dart';

class AppProviders extends StatelessWidget {
  late final FavouritePlaceRepository favouritePlaceDataRepository;
  late final PlaceRepository networkPlaceRepository;
  final Widget child;

  AppProviders({
    Key? key,
    required this.child,
  }) : super(key: key) {
    final networkPlaceRepository = NetworkPlaceRepository(DioApi());
    favouritePlaceDataRepository = FavouritePlaceDataRepository();
    this.networkPlaceRepository = networkPlaceRepository;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FavouritePlacesBloc(
            FavouritePlaceInteractor(
              favouritePlaceDataRepository,
            ),
          )..add(
            FavoritePlacesInitEvent(),
          ),
        ),
        BlocProvider(
          create: (context) => SettingsCubit(
            SettingsInteractor(),
          ),
        ),
      ],
      child: MultiProvider(
        providers: [
          Provider(
            create: (context) => PlaceInteractorProvider(
              placeRepository: networkPlaceRepository,
              favouritePlaceRepository: favouritePlaceDataRepository,
            ),
          ),
          ChangeNotifierProvider(create: (context) => BottomBarProvider()),
          Provider(create: (context) => networkPlaceRepository),
        ],
        child: child,
      ),
    );
  }
}