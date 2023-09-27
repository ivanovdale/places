import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/model/coordinate_point.dart';
import 'package:places/core/presentation/widgets/custom_pickers/custom_action_picker/custom_action_picker.dart';
import 'package:places/features/map/domain/model/available_map.dart';
import 'package:places/features/map/domain/model/map_type.dart';
import 'package:places/features/map/presentation/map_launcher_cubit/map_launcher_cubit.dart';

class MapAppPicker extends StatelessWidget {
  final CoordinatePoint destination;
  final List<AvailableMap> maps;

  const MapAppPicker({
    super.key,
    required this.destination,
    required this.maps,
  });

  @override
  Widget build(BuildContext context) {
    return CustomActionPicker<MapType>(
      onActionPressed: (action) {
        context.read<MapLauncherCubit>().showDirections(
              mapType: action.type,
              destination: destination,
            );
      },
      closeOnPressed: true,
      actions: maps
          .map(
            (map) => (
              icon: map.icon,
              text: map.mapName,
              type: map.mapType,
            ),
          )
          .toList(),
    );
  }
}
