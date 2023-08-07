import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/api/dio_api.dart';
import 'package:places/core/data/interactor/place_interactor.dart';
import 'package:places/core/data/repository/network_place_repository.dart';
import 'package:places/core/domain/repository/place_repository.dart';
import 'package:places/core/presentation/widgets/custom_bottom_navigation_bar/cubit/bottom_navigation_cubit.dart';
import 'package:places/features/favourite_places/data/favourite_place_data_repository.dart';
import 'package:places/features/favourite_places/data/favourite_place_interactor.dart';
import 'package:places/features/favourite_places/domain/favourite_place_repository.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_bloc.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_event.dart';
import 'package:places/features/settings/domain/settings_interactor.dart';
import 'package:places/features/settings/presentation/cubit/settings_cubit.dart';
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
          create: (context) => BottomNavigationCubit(),
        ),
        BlocProvider(
          create: (context) => FavouritePlacesBloc(
            FavouritePlaceInteractor(
              favouritePlaceDataRepository,
            ),
          )..add(
              FavouritePlacesStarted(),
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
            create: (context) => PlaceInteractor(
              placeRepository: networkPlaceRepository,
              favouritePlaceRepository: favouritePlaceDataRepository,
            ),
          ),
          Provider(create: (context) => networkPlaceRepository),
        ],
        child: child,
      ),
    );
  }
}
