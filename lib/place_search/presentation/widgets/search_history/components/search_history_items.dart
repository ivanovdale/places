import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/place_search/presentation/widgets/search_history/components/clear_search_history_button.dart';
import 'package:places/place_search/presentation/widgets/search_history/components/delete_history_search_item_from_list_button.dart';
import 'package:places/place_search/presentation/widgets/search_history/components/history_search_item_text_button.dart';
import 'package:places/place_search/presentation/widgets/search_history/components/search_history_item_divider.dart';
import 'package:places/place_search/presentation/widgets/search_history/components/search_item.dart';

/// Элементы истории поиска.
class SearchHistoryItems extends StatelessWidget {
  final Set<Place> searchHistory;
  final VoidCallback? onClearHistoryPressed;
  final OnHistorySearchItemPressed? onHistorySearchItemPressed;
  final OnDeleteHistorySearchItemPressed? onDeleteHistorySearchItemPressed;

  const SearchHistoryItems({
    Key? key,
    required this.searchHistory,
    this.onClearHistoryPressed,
    this.onHistorySearchItemPressed,
    this.onDeleteHistorySearchItemPressed,
  }) : super(key: key);

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
        itemBuilder: (context, index) {
          return listOfItems[index];
        },
        separatorBuilder: (context, index) {
          // Не отрисовывать разделитель для последнего элемента.
          return (index != itemCount - 2)
              ? const SearchHistoryItemDivider()
              : const SizedBox.shrink();
        },
      ),
    );
  }
}
