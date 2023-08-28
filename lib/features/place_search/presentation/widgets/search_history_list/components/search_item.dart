import 'package:flutter/material.dart';
import 'package:places/features/place_search/domain/model/search_history_item.dart';
import 'package:places/features/place_search/presentation/widgets/search_history_list/components/delete_history_search_item_from_list_button.dart';
import 'package:places/features/place_search/presentation/widgets/search_history_list/components/history_search_item_text_button.dart';

/// Элемент истории поиска.
///
/// Содержит имя искомого ранее места.
/// Позволяет удалить элемент из списка истории поиска.
class SearchItem extends StatelessWidget {
  final SearchHistoryItem searchHistoryItem;
  final ValueSetter<SearchHistoryItem>? onHistorySearchItemPressed;
  final ValueSetter<SearchHistoryItem>? onDeleteHistorySearchItemPressed;

  const SearchItem({
    super.key,
    required this.searchHistoryItem,
    this.onHistorySearchItemPressed,
    this.onDeleteHistorySearchItemPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 8,
      ),
      child: Row(
        children: [
          HistorySearchItemTextButton(
            searchHistoryItem: searchHistoryItem,
            onHistorySearchItemPressed: onHistorySearchItemPressed,
          ),
          const Spacer(),
          DeleteHistorySearchItemFromListButton(
            searchHistoryItem: searchHistoryItem,
            onDeleteHistorySearchItemPressed: onDeleteHistorySearchItemPressed,
          ),
        ],
      ),
    );
  }
}
