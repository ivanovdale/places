import 'package:places/core/domain/model/coordinate_point.dart';

/// Отвечает за получение данных местоположения пользователя.
abstract interface class GeolocationRepository {
  Future<bool> requestPermission();
  Stream<CoordinatePoint> get userCurrentLocation;
  void dispose();
}
