import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/features/add_place/presentation/add_place_screen.dart';
import 'package:places/features/add_place/presentation/widgets/buttons/place_type_selection_button.dart';
import 'package:places/helpers/app_router.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/utils/string_extension.dart';

/// Поле выбора категории места.
class PlaceTypeSelectionField extends StatelessWidget {
  const PlaceTypeSelectionField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectionFieldTextStyle = theme.textTheme.bodyLarge?.copyWith(
      color: theme.colorScheme.secondary,
    );
    final dataStorage = InheritedAddPlaceBodyState.of(context);
    final selectedPlaceType = dataStorage.selectedPlaceType;
    final selectedPlaceTypeName =
        selectedPlaceType?.text.capitalize() ?? AppStrings.unselected;

    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 14.0,
      ),
      child: InkWell(
        onTap: () => selectPlaceTypeFromListOnNewScreen(context),
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
  Future<void> selectPlaceTypeFromListOnNewScreen(BuildContext context) async {
    final dataStorage = InheritedAddPlaceBodyState.of(context);

    final selectedPlaceType = await Navigator.pushNamed<PlaceTypes>(
      context,
      AppRouter.placeTypeSelection,
    );

    if (selectedPlaceType != null) {
      dataStorage.setSelectedPlaceType(selectedPlaceType);
    }
  }
}
