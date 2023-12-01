import 'package:map_launcher/map_launcher.dart' as map_launcher;
import 'package:places/core/domain/model/coordinate_point.dart';
import 'package:places/features/map/domain/model/available_map.dart';
import 'package:places/features/map/domain/model/directions_mode.dart';
import 'package:places/features/map/domain/model/map_type.dart';

extension MapActionTypeDtoExt on map_launcher.MapType {
  MapType toModel() => MapType.values.firstWhere(
        (mapType) => mapType.name == name,
      );
}

extension MapActionTypeExt on MapType {
  map_launcher.MapType toDto() => map_launcher.MapType.values.firstWhere(
        (mapType) => mapType.name == name,
      );
}

extension DirectionsModeDtoExt on map_launcher.DirectionsMode {
  DirectionsMode toModel() =>
      DirectionsMode.values.firstWhere((element) => element.name == name);
}

extension DirectionsModeExt on DirectionsMode {
  map_launcher.DirectionsMode toDto() => map_launcher.DirectionsMode.values
      .firstWhere((element) => element.name == name);
}

extension AvailableMapDtoExt on map_launcher.AvailableMap {
  AvailableMap toModel() => AvailableMap(
        mapName: mapName,
        mapType: mapType.toModel(),
        icon: icon,
      );
}

extension AvailableMapListDtoExt on List<map_launcher.AvailableMap> {
  List<AvailableMap> toModelList() => map((e) => e.toModel()).toList();
}

extension AvailableMapExt on AvailableMap {
  map_launcher.AvailableMap toDto() => map_launcher.AvailableMap(
        mapName: mapName,
        mapType: mapType.toDto(),
        icon: icon,
      );
}

extension CoordinatePointExt on CoordinatePoint {
  map_launcher.Coords toCoords() => map_launcher.Coords(lat, lon);
  map_launcher.Waypoint toWaypoint() => map_launcher.Waypoint(lat, lon);
}

extension ListCoordinatePointExt on List<CoordinatePoint> {
  List<map_launcher.Waypoint> toWaypointList() => map((e) => e.toWaypoint()).toList();
}
