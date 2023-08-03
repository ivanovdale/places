import 'package:flutter/material.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/utils/string_extension.dart';
import 'package:places/features/add_place/presentation/widgets/buttons/place_type_selection_button.dart';
import 'package:places/core/helpers/app_router.dart';
import 'package:places/core/helpers/app_strings.dart';

/// Поле выбора категории места.
class PlaceTypeSelectionField extends StatelessWidget {
  final PlaceTypes? placeType;
  final ValueSetter<PlaceTypes> onPlaceTypeSelected;

  const PlaceTypeSelectionField({
    Key? key,
    this.placeType,
    required this.onPlaceTypeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectionFieldTextStyle = theme.textTheme.bodyLarge?.copyWith(
      color: theme.colorScheme.secondary,
    );
    final selectedPlaceTypeName =
        placeType?.text.capitalize() ?? AppStrings.unselected;

    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 14.0,
      ),
      child: InkWell(
        onTap: () => selectPlaceTypeFromListOnNewScreen(
          context,
          placeType: placeType,
        ),
        child: Row(
          children: [
            Text(
              selectedPlaceTypeName,
              style: selectionFieldTextStyle,
            ),
            const Spacer(),
            const PlaceTypeSelectionButton(),
          ],
        ),
      ),
    );
  }

  /// Позволяет выбрать тип места из списка на новом экране.
  Future<void> selectPlaceTypeFromListOnNewScreen(
    BuildContext context, {
    PlaceTypes? placeType,
  }) async {
    final selectedPlaceType = await Navigator.pushNamed<PlaceTypes>(
      context,
      AppRouter.placeTypeSelection,
      arguments: {
        'placeType': placeType,
      },
    );

    if (selectedPlaceType != null) {
      onPlaceTypeSelected.call(selectedPlaceType);
    }
  }
}
