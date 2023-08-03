import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/custom_text_button.dart';
import 'package:places/core/helpers/app_strings.dart';

/// Кнопка указания места на карте.
class MarkOnMapButton extends StatelessWidget {
  const MarkOnMapButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomTextButton(
      AppStrings.markOnMap,
      textStyle: theme.textTheme.labelLarge?.copyWith(
        color: theme.colorScheme.primary,
      ),
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 12.0,
        bottom: 37.0,
      ),
    );
  }
}