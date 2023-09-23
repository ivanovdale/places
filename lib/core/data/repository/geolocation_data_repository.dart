import 'dart:async';

import 'package:places/core/data/dto/location_permission_dto.dart';
import 'package:places/core/domain/model/coordinate_point.dart';
import 'package:places/core/domain/repository/geolocation_repository.dart';
import 'package:places/core/domain/source/geolocation/geolocation_api.dart';
import 'package:rxdart/rxdart.dart';

final class GeolocationDataRepository implements GeolocationRepository {
  GeolocationDataRepository({
    required GeolocationApi geolocationApi,
  }) : _geolocationApi = geolocationApi {
    _initialize();
  }

  final StreamController<CoordinatePoint> _geolocationStreamController =
      BehaviorSubject<CoordinatePoint>();

  final GeolocationApi _geolocationApi;

  @override
  Stream<CoordinatePoint> get userCurrentLocation =>
      _geolocationStreamController.stream.asBroadcastStream();

  Future<void> _initialize() async {
    if (await _isLocationPermissionAllowed()) {
      final position = await _geolocationApi.getCurrentPosition();
      final currentLocation = CoordinatePoint(
        lat: position.latitude,
        lon: position.longitude,
      );
      _geolocationStreamController.add(currentLocation);
    } else {
      _geolocationStreamController.add(CoordinatePoint.defaults());
    }
  }

  Future<bool> _isLocationPermissionAllowed() async {
    final permission = await _geolocationApi.checkPermission();

    return permission.isAllowed;
  }

  @override
  Future<void> reinitializeUserCurrentLocation() => _initialize();

  @override
  Future<bool> requestPermission() async {
    final permission = await _geolocationApi.requestPermission();

    return permission.isAllowed;
  }

  @override
  void dispose() => _geolocationStreamController.close();
}
