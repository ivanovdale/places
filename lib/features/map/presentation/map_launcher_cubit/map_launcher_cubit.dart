import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/interactor/geolocation_interactor.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/favourite_places/domain/interactor/favourite_place_interactor.dart';
import 'package:places/features/map/domain/interactor/map_launcher_interactor.dart';
import 'package:places/features/map/domain/model/available_map.dart';
import 'package:places/features/map/domain/model/map_type.dart';

part 'map_launcher_state.dart';

class MapLauncherCubit extends Cubit<MapLauncherState> {
  final MapLauncherInteractor _mapLauncherInteractor;
  final GeolocationInteractor _geolocationInteractor;
  final FavouritePlaceInteractor _favouritePlaceInteractor;

  MapLauncherCubit({
    required MapLauncherInteractor mapLauncherInteractor,
    required GeolocationInteractor geolocationInteractor,
    required FavouritePlaceInteractor favouritePlaceInteractor,
  })  : _mapLauncherInteractor = mapLauncherInteractor,
        _geolocationInteractor = geolocationInteractor,
        _favouritePlaceInteractor = favouritePlaceInteractor,
        super(const MapLauncherInitial());

  Future<void> openMapAppPicker() async {
    final installedMaps = await _mapLauncherInteractor.installedMaps;
    emit(MapLauncherShowInstalledMapsPicker(installedMaps: installedMaps));
  }

  Future<void> showDirections({
    required MapType mapType,
    required Place place,
  }) async {
    final origin = await _geolocationInteractor.userCurrentLocation.first;

    await _favouritePlaceInteractor.updateFavouriteVisited(
      place,
      visited: true,
    );
    await _mapLauncherInteractor.showDirections(
      mapType: mapType,
      destination: place.coordinatePoint,
      origin: origin,
    );
  }
}
