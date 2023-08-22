import 'package:places/core/api/dio_api.dart';
import 'package:places/core/data/repository/first_enter_data_repository.dart';
import 'package:places/core/data/repository/network_place_repository.dart';
import 'package:places/core/data/storage/shared_preferences_storage.dart';
import 'package:places/core/domain/interactor/first_enter_interactor.dart';
import 'package:places/core/domain/interactor/place_interactor.dart';
import 'package:places/core/domain/repository/place_repository.dart';
import 'package:places/core/domain/storage/key_value_storage.dart';
import 'package:places/features/favourite_places/data/favourite_place_data_repository.dart';
import 'package:places/features/favourite_places/data/favourite_place_interactor.dart';
import 'package:places/features/favourite_places/domain/favourite_place_repository.dart';
import 'package:places/features/place_filters/data/place_filters_data_repository.dart';
import 'package:places/features/place_filters/domain/place_filters_interactor.dart';
import 'package:places/features/place_filters/domain/place_filters_repository.dart';
import 'package:places/features/settings/data/settings_data_repository.dart';
import 'package:places/features/settings/domain/settings_interactor.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class AppDependencies {
  final FavouritePlaceRepository favouritePlaceRepository;
  final PlaceRepository placeRepository;
  final PlaceFiltersRepository placeFiltersRepository;

  final FavouritePlaceInteractor favouritePlaceInteractor;
  final PlaceInteractor placeInteractor;
  final SettingsInteractor settingsInteractor;
  final PlaceFiltersInteractor placeFiltersInteractor;
  final FirstEnterInteractor firstEnterInteractor;

  AppDependencies._({
    required this.favouritePlaceRepository,
    required this.placeRepository,
    required this.placeFiltersRepository,
    required this.favouritePlaceInteractor,
    required this.placeInteractor,
    required this.settingsInteractor,
    required this.placeFiltersInteractor,
    required this.firstEnterInteractor,
  });

  static Future<AppDependencies> getDependencies() async {
    // Хранилища.
    final sharedPreferences = await SharedPreferences.getInstance();
    final KeyValueStorage keyValueStorage = SharedPreferencesStorage(
      sharedPreferences: sharedPreferences,
    );

    // Репозитории.
    final placeRepository = NetworkPlaceRepository(DioApi());
    final favouritePlaceRepository = FavouritePlaceDataRepository();
    final placeFiltersRepository = PlaceFiltersDataRepository(
      keyValueStorage: keyValueStorage,
    );
    final settingsRepository = SettingsDataRepository(
      keyValueStorage: keyValueStorage,
    );
    final firstEnterRepository = FirstEnterDataRepository(
      keyValueStorage: keyValueStorage,
    );

    // Use cases.
    final favouritePlaceInteractor = FavouritePlaceInteractor(
      favouritePlaceRepository,
    );
    final placeInteractor = PlaceInteractor(
      placeRepository: placeRepository,
      favouritePlaceRepository: favouritePlaceRepository,
      placeFiltersRepository: placeFiltersRepository,
    );
    final settingsInteractor = SettingsInteractor(
      settingsRepository: settingsRepository,
    );
    final placeFiltersInteractor = PlaceFiltersInteractor(
      placeFiltersRepository: placeFiltersRepository,
    );
    final firstEnterInteractor = FirstEnterInteractor(
      firstEnterRepository: firstEnterRepository,
    );

    return AppDependencies._(
      favouritePlaceRepository: favouritePlaceRepository,
      favouritePlaceInteractor: favouritePlaceInteractor,
      placeRepository: placeRepository,
      placeFiltersRepository: placeFiltersRepository,
      placeInteractor: placeInteractor,
      settingsInteractor: settingsInteractor,
      placeFiltersInteractor: placeFiltersInteractor,
      firstEnterInteractor: firstEnterInteractor,
    );
  }

  void dispose() => placeFiltersRepository.dispose();
}
