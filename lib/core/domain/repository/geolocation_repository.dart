import 'package:places/core/domain/model/coordinate_point.dart';

/// Отвечает за получение данных местоположения пользователя.
abstract interface class GeolocationRepository {
  Future<bool> isLocationPermissionAllowed();
  Future<bool> requestPermission();
  Stream<CoordinatePoint> get userCurrentLocation;
  Future<void> reinitializeUserCurrentLocation();
  void dispose();
}
