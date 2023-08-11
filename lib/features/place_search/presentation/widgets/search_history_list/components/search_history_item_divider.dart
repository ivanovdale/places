import 'package:flutter/material.dart';
import 'package:places/core/presentation/widgets/custom_divider.dart';

/// Разделитель между элементами истории поиска.
class SearchHistoryItemDivider extends StatelessWidget {
  const SearchHistoryItemDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;

    return CustomDivider(
      color: secondaryColor.withOpacity(0.2),
      thickness: 0.8,
      padding: const EdgeInsets.only(
        top: 13,
        bottom: 15,
      ),
    );
  }
}
