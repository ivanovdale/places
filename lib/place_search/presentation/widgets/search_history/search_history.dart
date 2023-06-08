import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/place_search/presentation/widgets/search_history/components/delete_history_search_item_from_list_button.dart';
import 'package:places/place_search/presentation/widgets/search_history/components/history_search_item_text_button.dart';
import 'package:places/place_search/presentation/widgets/search_history/components/search_history_list.dart';

/// Отображает историю поиска.
class SearchHistory extends StatelessWidget {
  final Set<Place> searchHistory;
  final bool isSearchStringEmpty;
  final VoidCallback? onClearHistoryPressed;
  final OnHistorySearchItemPressed? onHistorySearchItemPressed;
  final OnDeleteHistorySearchItemPressed? onDeleteHistorySearchItemPressed;

  const SearchHistory({
    Key? key,
    required this.searchHistory,
    required this.isSearchStringEmpty,
    this.onClearHistoryPressed,
    this.onHistorySearchItemPressed,
    this.onDeleteHistorySearchItemPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Не показывать историю поиска, если она пуста, или если начат поиск мест.
    return searchHistory.isEmpty || isSearchStringEmpty
        ? const SizedBox.shrink()
        : SearchHistoryList(
            searchHistory: searchHistory,
            onClearHistoryPressed: onClearHistoryPressed,
            onHistorySearchItemPressed: onHistorySearchItemPressed,
            onDeleteHistorySearchItemPressed: onDeleteHistorySearchItemPressed,
          );
  }
}
