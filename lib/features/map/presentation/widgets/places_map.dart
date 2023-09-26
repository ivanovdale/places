import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/model/coordinate_point.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/map/presentation/chosen_place_cubit/chosen_place_cubit.dart';
import 'package:places/features/map/utils/placemark_map_object_helper.dart';
import 'package:places/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class PlacesMap extends StatelessWidget {
  final List<Place> places;
  final CoordinatePoint? userLocation;
  final MapCreatedCallback? onMapCreated;

  const PlacesMap({
    super.key,
    required this.places,
    this.userLocation,
    this.onMapCreated,
  });

  @override
  Widget build(BuildContext context) {
    return YandexMap(
      onMapCreated: onMapCreated,
      onCameraPositionChanged: (
        cameraPosition,
        reason,
        finished,
      ) =>
          context.read<ChosenPlaceCubit>().resetChosenPlace(),
      nightModeEnabled: context.watch<SettingsCubit>().state.isDarkModeEnabled,
      mapObjects: PlacemarkMapObjectHelper.getMapObjects(
        places: places,
        userLocation: userLocation,
        addUserPlacemark: true,
        onPlacemarkObjectTap: (place) =>
            context.read<ChosenPlaceCubit>().updateChosenPlace(place),
      ),
    );
  }
}
