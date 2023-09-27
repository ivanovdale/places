import 'package:places/core/domain/model/coordinate_point.dart';
import 'package:places/features/map/domain/model/available_map.dart';
import 'package:places/features/map/domain/model/directions_mode.dart';
import 'package:places/features/map/domain/model/map_type.dart';

abstract interface class MapLauncherRepository {
  Future<List<AvailableMap>> get installedMaps;

  Future<void> showDirections({
    required MapType mapActionType,
    required CoordinatePoint destination,
    String? destinationTitle,
    CoordinatePoint? origin,
    String? originTitle,
    List<CoordinatePoint>? waypoints,
    DirectionsMode? directionsMode = DirectionsMode.walking,
    Map<String, String>? extraParams,
  });
}
