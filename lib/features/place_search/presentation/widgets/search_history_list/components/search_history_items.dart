import 'package:flutter/material.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/place_search/presentation/widgets/search_history_list/components/clear_search_history_button.dart';
import 'package:places/features/place_search/presentation/widgets/search_history_list/components/search_history_item_divider.dart';
import 'package:places/features/place_search/presentation/widgets/search_history_list/components/search_item.dart';

/// Элементы истории поиска.
class SearchHistoryItems extends StatelessWidget {
  final Set<Place> searchHistory;
  final VoidCallback? onClearHistoryPressed;
  final ValueSetter<Place>? onHistorySearchItemPressed;
  final ValueSetter<Place>? onDeleteHistorySearchItemPressed;

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
          (place) => SearchItem(
            place: place,
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
