import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/interactor/geolocation_interactor.dart';
import 'package:places/core/domain/model/coordinate_point.dart';
import 'package:places/features/map/domain/interactor/map_launcher_interactor.dart';
import 'package:places/features/map/domain/model/available_map.dart';
import 'package:places/features/map/domain/model/map_type.dart';

part 'map_launcher_state.dart';

class MapLauncherCubit extends Cubit<MapLauncherState> {
  final MapLauncherInteractor _mapLauncherInteractor;
  final GeolocationInteractor _geolocationInteractor;

  MapLauncherCubit({
    required MapLauncherInteractor mapLauncherInteractor,
    required GeolocationInteractor geolocationInteractor,
  })  : _mapLauncherInteractor = mapLauncherInteractor,
        _geolocationInteractor = geolocationInteractor,
        super(const MapLauncherInitial());

  Future<void> openMapAppPicker() async {
    final installedMaps = await _mapLauncherInteractor.installedMaps;
    emit(MapLauncherShowInstalledMapsPicker(installedMaps: installedMaps));
  }

  Future<void> showDirections({
    required MapType mapType,
    required CoordinatePoint destination,
  }) async {
    final origin = await _geolocationInteractor.userCurrentLocation.first;
    await _mapLauncherInteractor.showDirections(
      mapType: mapType,
      destination: destination,
      origin: origin,
    );
  }
}
