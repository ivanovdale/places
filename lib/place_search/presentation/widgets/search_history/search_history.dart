import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/place_search/presentation/widgets/search_history/components/delete_history_search_item_from_list_button.dart';
import 'package:places/place_search/presentation/widgets/search_history/components/history_search_item_text_button.dart';
import 'package:places/place_search/presentation/widgets/search_history/components/search_history_list.dart';

typedef ShowCondition = bool Function();

/// Отображает историю поиска.
class SearchHistory extends StatelessWidget {
  final Set<Place> searchHistory;
  final VoidCallback? onClearHistoryPressed;
  final OnHistorySearchItemPressed? onHistorySearchItemPressed;
  final OnDeleteHistorySearchItemPressed? onDeleteHistorySearchItemPressed;
  final ShowCondition showCondition;

  const SearchHistory({
    Key? key,
    required this.searchHistory,
    this.onClearHistoryPressed,
    this.onHistorySearchItemPressed,
    this.onDeleteHistorySearchItemPressed,
    required this.showCondition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Не показывать историю поиска, если она пуста, или если начат поиск мест.
    return showCondition()
        ? SearchHistoryList(
            searchHistory: searchHistory,
            onClearHistoryPressed: onClearHistoryPressed,
            onHistorySearchItemPressed: onHistorySearchItemPressed,
            onDeleteHistorySearchItemPressed: onDeleteHistorySearchItemPressed,
          )
        : const SizedBox.shrink();
  }
}
