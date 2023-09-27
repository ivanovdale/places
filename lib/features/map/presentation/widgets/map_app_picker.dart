import 'package:flutter/material.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/presentation/widgets/custom_pickers/custom_action_picker/components/picker_actions.dart';
import 'package:places/core/presentation/widgets/custom_pickers/custom_action_picker/custom_action_picker.dart';
import 'package:places/features/map/domain/model/available_map.dart';
import 'package:places/features/map/domain/model/map_type.dart';

class MapAppPicker extends StatelessWidget {
  final Place place;
  final List<AvailableMap> maps;
  final ValueSetter<ActionElement<MapType>> onMapPressed;

  const MapAppPicker({
    super.key,
    required this.place,
    required this.maps,
    required this.onMapPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomActionPicker<MapType>(
      onActionPressed: onMapPressed,
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
