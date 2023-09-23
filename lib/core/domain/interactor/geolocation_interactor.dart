import 'package:places/core/domain/model/coordinate_point.dart';
import 'package:places/core/domain/repository/geolocation_repository.dart';

final class GeolocationInteractor {
  const GeolocationInteractor({
    required GeolocationRepository geolocationRepository,
  }) : _geolocationRepository = geolocationRepository;

  final GeolocationRepository _geolocationRepository;

  Future<bool> requestPermission() =>
      _geolocationRepository.requestPermission();

  Future<void> reinitializeUserCurrentLocation() =>
      _geolocationRepository.reinitializeUserCurrentLocation();

  Stream<CoordinatePoint> get userCurrentLocation =>
      _geolocationRepository.userCurrentLocation;
}
