import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/app/app_dependencies.dart';
import 'package:places/core/presentation/widgets/custom_bottom_navigation_bar/cubit/bottom_navigation_cubit.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_bloc.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_event.dart';
import 'package:places/features/map/presentation/map_launcher_cubit/map_launcher_cubit.dart';
import 'package:places/features/place_list/presentation/bloc/place_list_bloc.dart';
import 'package:places/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:provider/provider.dart';

class AppProviders extends StatelessWidget {
  final Widget child;
  final AppDependencies _appDependencies;

  const AppProviders({
    super.key,
    required this.child,
    required AppDependencies appDependencies,
  }) : _appDependencies = appDependencies;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => BottomNavigationCubit(),
        ),
        BlocProvider(
          create: (_) => FavouritePlacesBloc(
            _appDependencies.favouritePlaceInteractor,
          )..add(
              FavouritePlacesSubscriptionRequested(),
            ),
        ),
        BlocProvider(
          create: (_) => SettingsCubit(
            settingsInteractor: _appDependencies.settingsInteractor,
          )..initialize(),
        ),
        BlocProvider(
          create: (_) => PlaceListBloc(
            placeInteractor: _appDependencies.placeInteractor,
            placeFiltersInteractor: _appDependencies.placeFiltersInteractor,
            favouritePlaceInteractor: _appDependencies.favouritePlaceInteractor,
          )
            ..add(
              PlaceListStarted(),
            )
            ..add(
              PlaceFiltersSubscriptionRequested(),
            ),
        ),
        BlocProvider(
          create: (_) => MapLauncherCubit(
            mapLauncherInteractor: _appDependencies.mapLauncherInteractor,
            geolocationInteractor: _appDependencies.geolocationInteractor,
            favouritePlaceInteractor: _appDependencies.favouritePlaceInteractor,
          ),
        )
      ],
      child: MultiProvider(
        providers: [
          Provider.value(
            value: _appDependencies.database,
          ),
          Provider.value(
            value: _appDependencies.placeRepository,
          ),
          Provider.value(
            value: _appDependencies.placeInteractor,
          ),
          Provider.value(
            value: _appDependencies.placeFiltersInteractor,
          ),
          Provider.value(
            value: _appDependencies.firstEnterInteractor,
          ),
          Provider.value(
            value: _appDependencies.favouritePlaceInteractor,
          ),
          Provider.value(
            value: _appDependencies.photoInteractor,
          ),
          Provider.value(
            value: _appDependencies.geolocationInteractor,
          ),
        ],
        child: child,
      ),
    );
  }
}
