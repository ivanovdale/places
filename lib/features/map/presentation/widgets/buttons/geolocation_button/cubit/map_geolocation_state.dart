part of 'map_geolocation_cubit.dart';

abstract class MapGeolocationState {}

class MapGeolocationInitial extends MapGeolocationState {}

class MapGeolocationStartMovingCamera extends MapGeolocationState {
  final CoordinatePoint coordinatePoint;

  MapGeolocationStartMovingCamera({required this.coordinatePoint});
}
