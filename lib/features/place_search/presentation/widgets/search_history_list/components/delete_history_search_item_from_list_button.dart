import 'package:flutter/material.dart';
import 'package:places/core/presentation/widgets/custom_buttons/custom_icon_button.dart';
import 'package:places/features/place_search/domain/model/search_history_item.dart';

/// Кнопка удаления элемента истории поиска из списка.
class DeleteHistorySearchItemFromListButton extends StatelessWidget {
  final SearchHistoryItem searchHistoryItem;
  final ValueSetter<SearchHistoryItem>? onDeleteHistorySearchItemPressed;

  const DeleteHistorySearchItemFromListButton({
    super.key,
    required this.searchHistoryItem,
    this.onDeleteHistorySearchItemPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;

    return CustomIconButton(
      onPressed: () => onDeleteHistorySearchItemPressed?.call(searchHistoryItem),
      icon: Icons.close,
      color: secondaryColor.withOpacity(0.56),
    );
  }
}
