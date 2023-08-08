import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_strings.dart';

/// Заголовок фильтров по категории места.
class PlaceTypesTitle extends StatelessWidget {
  const PlaceTypesTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary.withOpacity(0.56);

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 16,
        ),
        child: Text(
          AppStrings.placeTypes,
          style: theme.textTheme.bodySmall?.copyWith(
            color: secondaryColor,
          ),
        ),
      ),
    );
  }
}
