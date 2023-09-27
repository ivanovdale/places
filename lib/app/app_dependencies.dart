import 'package:image_picker/image_picker.dart';
import 'package:places/core/api/dio_api.dart';
import 'package:places/core/data/repository/first_enter_data_repository.dart';
import 'package:places/core/data/repository/geolocation_data_repository.dart';
import 'package:places/core/data/repository/network_place_repository.dart';
import 'package:places/core/data/source/database/database.dart';
import 'package:places/core/data/source/database/database_impl.dart';
import 'package:places/core/data/source/geolocation/geolocation_api_impl.dart';
import 'package:places/core/data/source/storage/shared_preferences_storage.dart';
import 'package:places/core/domain/interactor/first_enter_interactor.dart';
import 'package:places/core/domain/interactor/geolocation_interactor.dart';
import 'package:places/core/domain/interactor/place_interactor.dart';
import 'package:places/core/domain/repository/geolocation_repository.dart';
import 'package:places/core/domain/repository/place_repository.dart';
import 'package:places/core/domain/source/storage/key_value_storage.dart';
import 'package:places/features/add_place/data/api/image_picker_api.dart';
import 'package:places/features/add_place/data/repository/photo_data_repository.dart';
import 'package:places/features/add_place/domain/interactor/photo_interactor.dart';
import 'package:places/features/favourite_places/data/repository/favourite_place_data_repository.dart';
import 'package:places/features/favourite_places/domain/interactor/favourite_place_interactor.dart';
import 'package:places/features/favourite_places/domain/repository/favourite_place_repository.dart';
import 'package:places/features/map/data/api/map_launcher_api.dart';
import 'package:places/features/map/data/repository/map_launcher_data_repository.dart';
import 'package:places/features/map/domain/interactor/map_launcher_interactor.dart';
import 'package:places/features/place_filters/data/place_filters_data_repository.dart';
import 'package:places/features/place_filters/domain/place_filters_interactor.dart';
import 'package:places/features/place_filters/domain/place_filters_repository.dart';
import 'package:places/features/settings/data/settings_data_repository.dart';
import 'package:places/features/settings/domain/settings_interactor.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class AppDependencies {
  final Database database;

  final FavouritePlaceRepository favouritePlaceRepository;
  final PlaceRepository placeRepository;
  final PlaceFiltersRepository placeFiltersRepository;
  final GeolocationRepository geolocationRepository;

  final FavouritePlaceInteractor favouritePlaceInteractor;
  final PlaceInteractor placeInteractor;
  final SettingsInteractor settingsInteractor;
  final PlaceFiltersInteractor placeFiltersInteractor;
  final FirstEnterInteractor firstEnterInteractor;
  final PhotoInteractor photoInteractor;
  final GeolocationInteractor geolocationInteractor;
  final MapLauncherInteractor mapLauncherInteractor;

  AppDependencies._({
    required this.database,
    required this.favouritePlaceRepository,
    required this.placeRepository,
    required this.placeFiltersRepository,
    required this.geolocationRepository,
    required this.favouritePlaceInteractor,
    required this.placeInteractor,
    required this.settingsInteractor,
    required this.placeFiltersInteractor,
    required this.firstEnterInteractor,
    required this.photoInteractor,
    required this.geolocationInteractor,
    required this.mapLauncherInteractor,
  });

  static Future<AppDependencies> getDependencies() async {
    // Http-клиент.
    final dioApi = DioApi();

    // База данных.
    final database = DatabaseImpl(
      dbName: 'database.db',
      logStatements: false,
    );

    // Хранилище.
    final sharedPreferences = await SharedPreferences.getInstance();
    final KeyValueStorage keyValueStorage = SharedPreferencesStorage(
      sharedPreferences: sharedPreferences,
    );

    // Репозитории.
    final placeRepository = NetworkPlaceRepository(dioApi);
    final favouritePlaceRepository = FavouritePlaceDataRepository(
      database: database,
    );
    final placeFiltersRepository = PlaceFiltersDataRepository(
      keyValueStorage: keyValueStorage,
    );
    final settingsRepository = SettingsDataRepository(
      keyValueStorage: keyValueStorage,
    );
    final firstEnterRepository = FirstEnterDataRepository(
      keyValueStorage: keyValueStorage,
    );
    final geolocationRepository = GeolocationDataRepository(
      geolocationApi: GeolocationApiImpl(),
    );
    final mapLauncherRepository = MapLauncherDataRepository(
      mapLauncherApi: MapLauncherApiImpl(),
    );

    // Use cases.
    final favouritePlaceInteractor = FavouritePlaceInteractor(
      favouritePlaceRepository: favouritePlaceRepository,
    );
    final placeInteractor = PlaceInteractor(
      placeRepository: placeRepository,
      favouritePlaceRepository: favouritePlaceRepository,
      placeFiltersRepository: placeFiltersRepository,
      geolocationRepository: geolocationRepository,
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
    final photoInteractor = PhotoInteractor(
      photoRepository: PhotoDataRepository(
        imagePickerApi: ImagePickerApiImpl(
          imagePicker: ImagePicker(),
        ),
        apiUtil: dioApi,
      ),
    );
    final geolocationInteractor = GeolocationInteractor(
      geolocationRepository: geolocationRepository,
    );
    final mapLauncherInteractor = MapLauncherInteractor(
      mapLauncherRepository: mapLauncherRepository,
    );

    return AppDependencies._(
      database: database,
      favouritePlaceRepository: favouritePlaceRepository,
      favouritePlaceInteractor: favouritePlaceInteractor,
      placeRepository: placeRepository,
      placeFiltersRepository: placeFiltersRepository,
      geolocationRepository: geolocationRepository,
      placeInteractor: placeInteractor,
      settingsInteractor: settingsInteractor,
      placeFiltersInteractor: placeFiltersInteractor,
      firstEnterInteractor: firstEnterInteractor,
      photoInteractor: photoInteractor,
      geolocationInteractor: geolocationInteractor,
      mapLauncherInteractor: mapLauncherInteractor,
    );
  }

  void dispose() {
    placeFiltersRepository.dispose();
    geolocationRepository.dispose();
  }
}
