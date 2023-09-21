import 'package:places/core/data/dto/location_permission_dto.dart';
import 'package:places/core/domain/model/coordinate_point.dart';
import 'package:places/core/domain/repository/geolocation_repository.dart';
import 'package:places/core/domain/source/geolocation/geolocation_api.dart';

final class GeolocationDataRepository implements GeolocationRepository {
  GeolocationDataRepository({
    required GeolocationApi geolocationApi,
  }) : _geolocationApi = geolocationApi;

  final GeolocationApi _geolocationApi;

  @override
  Future<bool> requestPermission() async {
    final permission = await _geolocationApi.requestPermission();

    return permission.isAllowed;
  }

  @override
  Future<bool> isLocationPermissionAllowed() async {
    final permission = await _geolocationApi.checkPermission();

    return permission.isAllowed;
  }

  @override
  Future<CoordinatePoint> getUserCurrentLocation() async {
    final position = await _geolocationApi.getCurrentPosition();

    return CoordinatePoint(
      lat: position.latitude,
      lon: position.longitude,
    );
  }
}
