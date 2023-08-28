import 'package:flutter/material.dart';
import 'package:places/features/place_search/domain/model/search_history_item.dart';
import 'package:places/features/place_search/presentation/widgets/search_history_list/components/clear_search_history_button.dart';
import 'package:places/features/place_search/presentation/widgets/search_history_list/components/search_history_item_divider.dart';
import 'package:places/features/place_search/presentation/widgets/search_history_list/components/search_item.dart';

/// Элементы истории поиска.
class SearchHistoryItems extends StatelessWidget {
  final Set<SearchHistoryItem> searchHistory;
  final VoidCallback? onClearHistoryPressed;
  final ValueSetter<SearchHistoryItem>? onHistorySearchItemPressed;
  final ValueSetter<SearchHistoryItem>? onDeleteHistorySearchItemPressed;

  const SearchHistoryItems({
    super.key,
    required this.searchHistory,
    this.onClearHistoryPressed,
    this.onHistorySearchItemPressed,
    this.onDeleteHistorySearchItemPressed,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> listOfItems;
    listOfItems = searchHistory
        .map(
          (searchHistoryItem) => SearchItem(
            searchHistoryItem: searchHistoryItem,
            onHistorySearchItemPressed: onHistorySearchItemPressed,
            onDeleteHistorySearchItemPressed: onDeleteHistorySearchItemPressed,
          ),
        )
        .cast<Widget>()
        .toList()
      ..add(
        ClearSearchHistoryButton(
          onPressed: onClearHistoryPressed,
        ), // Кнопка очистки истории в конце списка.
      );

    final itemCount = listOfItems.length;

    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: itemCount,
        itemBuilder: (_, index) {
          return listOfItems[index];
        },
        separatorBuilder: (_, index) {
          // Не отрисовывать разделитель для последнего элемента.
          return (index != itemCount - 2)
              ? const SearchHistoryItemDivider()
              : const SizedBox.shrink();
        },
      ),
    );
  }
}
