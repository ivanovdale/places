import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/custom_divider.dart';

/// Разделитель между найденными местами.
class PlaceFoundItemDivider extends StatelessWidget {
  const PlaceFoundItemDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;

    return CustomDivider(
      color: secondaryColor.withOpacity(0.2),
      thickness: 0.8,
      height: 2,
      padding: const EdgeInsets.symmetric(vertical: 16),
    );
  }
}
