part of 'map_launcher_cubit.dart';

abstract class MapLauncherState {
  const MapLauncherState();
}

class MapLauncherInitial extends MapLauncherState {
  const MapLauncherInitial();
}

class MapLauncherShowInstalledMapsPicker extends MapLauncherState {
  final List<AvailableMap> installedMaps;

  const MapLauncherShowInstalledMapsPicker({
    required this.installedMaps,
  });
}
