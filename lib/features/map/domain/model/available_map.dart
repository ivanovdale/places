import 'package:places/core/presentation/widgets/custom_pickers/custom_action_picker/components/picker_actions.dart';
import 'package:places/features/map/domain/model/map_type.dart';

class AvailableMap {
  String mapName;
  MapType mapType;
  String icon;

  AvailableMap({
    required this.mapName,
    required this.mapType,
    required this.icon,
  });
}

extension AvailableMapListExt on List<AvailableMap> {
  List<ActionElement<MapType>> toActionElementList() => map(
        (e) => (
          icon: e.icon,
          text: e.mapName,
          type: e.mapType,
        ),
      ).toList();
}
