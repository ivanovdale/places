import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/custom_buttons/custom_text_button.dart';

/// Кнопка указания места на карте.
class MarkOnMapButton extends StatelessWidget {
  const MarkOnMapButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomTextButton(
      AppStrings.markOnMap,
      textStyle: theme.textTheme.labelLarge?.copyWith(
        color: theme.colorScheme.primary,
      ),
      padding: const EdgeInsets.only(
        left: 16,
        top: 12,
        bottom: 37,
      ),
    );
  }
}
