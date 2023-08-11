import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/custom_buttons/custom_elevated_button.dart';
import 'package:places/features/place_type_selection/presentation/cubit/place_type_selection_cubit.dart';

/// Кнопка сохранения категории места.
class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PlaceTypeSelectionCubit>();
    final currentPlaceType = cubit.state.placeType;

    // Логика изменения цвета кнопки в зависимости от выбранной категории.
    final theme = Theme.of(context);
    var saveButtonBackgroundColor = theme.colorScheme.primary;
    var saveButtonTextColor = theme.colorScheme.onBackground;
    if (currentPlaceType == null) {
      saveButtonBackgroundColor = theme.colorScheme.secondaryContainer;
      saveButtonTextColor = theme.colorScheme.secondary.withOpacity(0.56);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      child: CustomElevatedButton(
        AppStrings.save,
        backgroundColor: saveButtonBackgroundColor,
        height: 48,
        textStyle: theme.textTheme.bodyMedium?.copyWith(
          color: saveButtonTextColor,
          fontWeight: FontWeight.w700,
        ),
        onPressed: () {
          if (currentPlaceType != null) {
            Navigator.pop(context, currentPlaceType);
          }
        },
      ),
    );
  }
}
