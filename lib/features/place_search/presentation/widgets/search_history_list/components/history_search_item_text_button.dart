import 'package:flutter/material.dart';
import 'package:places/core/presentation/widgets/custom_buttons/custom_text_button.dart';
import 'package:places/features/place_search/domain/model/search_history_item.dart';

/// Текстовая кнопка элемента истории поиска.
///
/// При нажатии заполняется поле поиска места.
class HistorySearchItemTextButton extends StatelessWidget {
  final SearchHistoryItem searchHistoryItem;
  final ValueSetter<SearchHistoryItem>? onHistorySearchItemPressed;

  const HistorySearchItemTextButton({
    super.key,
    required this.searchHistoryItem,
    this.onHistorySearchItemPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;

    return CustomTextButton(
      searchHistoryItem.name,
      textStyle: theme.textTheme.bodyLarge?.copyWith(
        color: secondaryColor,
      ),
      alignment: Alignment.centerLeft,

      // Заполняет поле поиска заданным элементом.
      onPressed: () => onHistorySearchItemPressed?.call(searchHistoryItem),
    );
  }
}
