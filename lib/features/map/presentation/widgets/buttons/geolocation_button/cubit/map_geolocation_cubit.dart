import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/interactor/geolocation_interactor.dart';
import 'package:places/core/domain/model/coordinate_point.dart';

part 'map_geolocation_state.dart';

class MapGeolocationCubit extends Cubit<MapGeolocationState> {
  final GeolocationInteractor _geolocationInteractor;

  MapGeolocationCubit({
    required GeolocationInteractor geolocationInteractor,
  })  : _geolocationInteractor = geolocationInteractor,
        super(MapGeolocationInitial());

  Future<void> showUserOnMap() async {
    final isLocationPermissionAllowed =
        await _geolocationInteractor.isLocationPermissionAllowed();
    if (!isLocationPermissionAllowed) {
      await _geolocationInteractor.requestPermission();
    }

    final coordinatePoint =
        await _geolocationInteractor.userCurrentLocation.first;

    emit(MapGeolocationStartMovingCamera(coordinatePoint: coordinatePoint));
  }
}
