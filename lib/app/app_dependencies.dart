import 'package:places/core/api/dio_api.dart';
import 'package:places/core/data/interactor/place_interactor.dart';
import 'package:places/core/data/repository/network_place_repository.dart';
import 'package:places/core/domain/repository/place_repository.dart';
import 'package:places/features/favourite_places/data/favourite_place_data_repository.dart';
import 'package:places/features/favourite_places/data/favourite_place_interactor.dart';
import 'package:places/features/favourite_places/domain/favourite_place_repository.dart';
import 'package:places/features/place_filters/data/place_filters_shared_preferences_repository.dart';
import 'package:places/features/place_filters/domain/place_filters_interactor.dart';
import 'package:places/features/place_filters/domain/place_filters_repository.dart';
import 'package:places/features/settings/domain/settings_interactor.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class AppDependencies {
  final SharedPreferences sharedPreferences;

  final FavouritePlaceRepository favouritePlaceDataRepository;
  final PlaceRepository networkPlaceRepository;
  final PlaceFiltersRepository placeFiltersRepository;

  final FavouritePlaceInteractor favouritePlaceInteractor;
  final PlaceInteractor placeInteractor;
  final SettingsInteractor settingsInteractor;
  final PlaceFiltersInteractor placeFiltersInteractor;

  AppDependencies._({
    required this.sharedPreferences,
    required this.favouritePlaceDataRepository,
    required this.networkPlaceRepository,
    required this.placeFiltersRepository,
    required this.favouritePlaceInteractor,
    required this.placeInteractor,
    required this.settingsInteractor,
    required this.placeFiltersInteractor,
  });

  static Future<AppDependencies> getDependencies() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final networkPlaceRepository = NetworkPlaceRepository(DioApi());
    final favouritePlaceDataRepository = FavouritePlaceDataRepository();
    final placeFiltersRepository = PlaceFiltersSharedPreferencesRepository(
      sharedPreferences: sharedPreferences,
    );

    final favouritePlaceInteractor = FavouritePlaceInteractor(
      favouritePlaceDataRepository,
    );
    final placeInteractor = PlaceInteractor(
      placeRepository: networkPlaceRepository,
      favouritePlaceRepository: favouritePlaceDataRepository,
      placeFiltersRepository: placeFiltersRepository,
    );
    final settingsInteractor = SettingsInteractor();
    final placeFiltersInteractor = PlaceFiltersInteractor(
      placeFiltersRepository: placeFiltersRepository,
    );

    return AppDependencies._(
      sharedPreferences: sharedPreferences,
      favouritePlaceDataRepository: favouritePlaceDataRepository,
      favouritePlaceInteractor: favouritePlaceInteractor,
      networkPlaceRepository: networkPlaceRepository,
      placeFiltersRepository: placeFiltersRepository,
      placeInteractor: placeInteractor,
      settingsInteractor: settingsInteractor,
      placeFiltersInteractor: placeFiltersInteractor,
    );
  }
}
