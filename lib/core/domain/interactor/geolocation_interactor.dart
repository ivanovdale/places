import 'package:places/core/domain/model/coordinate_point.dart';
import 'package:places/core/domain/repository/geolocation_repository.dart';

final class GeolocationInteractor {
  const GeolocationInteractor({
    required GeolocationRepository geolocationRepository,
  }) : _geolocationRepository = geolocationRepository;

  final GeolocationRepository _geolocationRepository;

  Future<bool> isLocationPermissionAllowed() =>
      _geolocationRepository.isLocationPermissionAllowed();

  Future<bool> requestPermission() async {
    final isLocationPermissionAllowed =
        await _geolocationRepository.requestPermission();
    if (isLocationPermissionAllowed) {
      await _geolocationRepository.reinitializeUserCurrentLocation();
    }

    return isLocationPermissionAllowed;
  }

  Future<void> reinitializeUserCurrentLocation() =>
      _geolocationRepository.reinitializeUserCurrentLocation();

  Stream<CoordinatePoint> get userCurrentLocation =>
      _geolocationRepository.userCurrentLocation;
}
