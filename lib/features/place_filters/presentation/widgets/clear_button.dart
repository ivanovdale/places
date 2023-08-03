import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/custom_text_button.dart';
import 'package:places/helpers/app_strings.dart';

/// Кнопка "Очистить" все фильтры.
class ClearButton extends StatelessWidget {
  const ClearButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO(ivanovdale):  Bloc
    final dataStorage = _InheritedFiltersScreenState.of(context);
    final theme = Theme.of(context);

    return CustomTextButton(
      AppStrings.clear,
      textStyle: theme.textTheme.labelLarge?.copyWith(
        color: theme.colorScheme.primary,
      ),
      padding: const EdgeInsets.only(right: 16.0),
      onPressed: dataStorage.resetAllFilters,
    );
  }
}
