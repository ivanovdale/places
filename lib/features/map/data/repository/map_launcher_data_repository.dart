import 'package:places/core/domain/model/coordinate_point.dart';
import 'package:places/features/map/data/api/map_launcher_api.dart';
import 'package:places/features/map/domain/model/available_map.dart';
import 'package:places/features/map/domain/model/directions_mode.dart';
import 'package:places/features/map/domain/model/map_type.dart';
import 'package:places/features/map/domain/repository/map_launcher_repository.dart';

final class MapLauncherDataRepository implements MapLauncherRepository {
  const MapLauncherDataRepository({
    required MapLauncherApi mapLauncherApi,
  }) : _mapLauncherApi = mapLauncherApi;

  final MapLauncherApi _mapLauncherApi;

  @override
  Future<List<AvailableMap>> get installedMaps => _mapLauncherApi.installedMaps;

  @override
  Future<void> showDirections({
    required MapType mapActionType,
    required CoordinatePoint destination,
    String? destinationTitle,
    CoordinatePoint? origin,
    String? originTitle,
    List<CoordinatePoint>? waypoints,
    DirectionsMode? directionsMode = DirectionsMode.walking,
    Map<String, String>? extraParams,
  }) =>
      _mapLauncherApi.showDirections(
        mapType: mapActionType,
        destination: destination,
        destinationTitle: destinationTitle,
        origin: origin,
        originTitle: originTitle,
        waypoints: waypoints,
        directionsMode: directionsMode,
        extraParams: extraParams,
      );
}
