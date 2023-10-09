import 'package:places/core/domain/model/coordinate_point.dart';
import 'package:places/features/map/domain/model/available_map.dart';
import 'package:places/features/map/domain/model/directions_mode.dart';
import 'package:places/features/map/domain/model/map_type.dart';
import 'package:places/features/map/domain/repository/map_launcher_repository.dart';

final class MapLauncherInteractor {
  const MapLauncherInteractor({
    required MapLauncherRepository mapLauncherRepository,
  }) : _mapLauncherRepository = mapLauncherRepository;
  final MapLauncherRepository _mapLauncherRepository;

  Future<List<AvailableMap>> get installedMaps =>
      _mapLauncherRepository.installedMaps;

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
      _mapLauncherRepository.showDirections(
        mapActionType: mapType,
        destination: destination,
        destinationTitle: destinationTitle,
        origin: origin,
        originTitle: originTitle,
        waypoints: waypoints,
        directionsMode: directionsMode,
        extraParams: extraParams,
      );
}
