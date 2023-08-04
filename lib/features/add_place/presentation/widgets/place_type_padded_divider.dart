import 'package:flutter/material.dart';
import 'package:places/core/presentation/widgets/custom_divider.dart';

/// Разделитель для типа достопримечательности с заданной толщиной и отступами.
class PlaceTypePaddedDivider extends StatelessWidget {
  const PlaceTypePaddedDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDivider(
      thickness: 0.8,
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 24,
      ),
      color: Theme.of(context).colorScheme.secondary.withOpacity(0.56),
    );
  }
}
