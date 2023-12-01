import 'package:map_launcher/map_launcher.dart' as map_launcher;
import 'package:places/core/domain/model/coordinate_point.dart';
import 'package:places/features/map/data/mapper/map_model_mappers_ext.dart';
import 'package:places/features/map/domain/model/available_map.dart';
import 'package:places/features/map/domain/model/directions_mode.dart';
import 'package:places/features/map/domain/model/map_type.dart';

abstract interface class MapLauncherApi {
  Future<List<AvailableMap>> get installedMaps;

  Future<void> showDirections({
    required MapType mapType,
    required CoordinatePoint destination,
    String? destinationTitle,
    CoordinatePoint? origin,
    String? originTitle,
    List<CoordinatePoint>? waypoints,
    DirectionsMode? directionsMode = DirectionsMode.walking,
    Map<String, String>? extraParams,
  });
}

final class MapLauncherApiImpl implements MapLauncherApi {
  @override
  Future<List<AvailableMap>> get installedMaps =>
      map_launcher.MapLauncher.installedMaps
          .then((value) => value.toModelList());

  @override
  Future<void> showDirections({
    required MapType mapType,
    required CoordinatePoint destination,
    String? destinationTitle,
    CoordinatePoint? origin,
    String? originTitle,
    List<CoordinatePoint>? waypoints,
    DirectionsMode? directionsMode = DirectionsMode.walking,
    Map<String, String>? extraParams,
  }) =>
      map_launcher.MapLauncher.showDirections(
        mapType: mapType.toDto(),
        destination: destination.toCoords(),
        destinationTitle: destinationTitle,
        origin: origin?.toCoords(),
        originTitle: originTitle,
        waypoints: waypoints?.toWaypointList(),
        directionsMode: directionsMode?.toDto(),
        extraParams: extraParams,
      );
}
