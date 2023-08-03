import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/custom_elevated_button.dart';
import 'package:places/helpers/app_strings.dart';

/// Кнопка "Показать" отфильтрованные места.
class ShowPlacesElevatedButton extends StatelessWidget {
  const ShowPlacesElevatedButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO(ivanovdale):  bloc
    final dataStorage = _InheritedFiltersScreenState.of(context);
    final filteredPlacesNumber = dataStorage.filteredPlacesNumber;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final buttonTextColor = colorScheme.background;
    final buttonBackgroundColor = colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 24.0,
      ),
      child: CustomElevatedButton(
        '${AppStrings.show} ($filteredPlacesNumber)',
        textStyle: theme.textTheme.bodyMedium?.copyWith(
          color: buttonTextColor,
        ),
        backgroundColor: buttonBackgroundColor,
        height: 48,
        onPressed: () => applyFilters(context),
      ),
    );
  }

  /// Возвращает выбранные фильтры на предыдущий экран, где они будут применены.
  void applyFilters(BuildContext context) {
    // TODO(ivanovdale):  bloc
    final dataStorage = _InheritedFiltersScreenState.of(context);
    final radius = dataStorage.radius;

    final selectedFilters = <String, Object>{
      'placeTypeFilters': dataStorage.selectedPlaceTypeFilters,
      'radius': radius,
    };

    Navigator.of(context).pop(selectedFilters);
  }
}