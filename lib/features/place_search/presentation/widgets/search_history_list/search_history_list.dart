import 'package:flutter/material.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/label_field_text.dart';
import 'package:places/features/place_search/presentation/widgets/search_history_list/components/search_history_items.dart';

/// Список истории поиска.
///
/// Содержит элементы истории поиска, кнопку очистки истории поиска.
class SearchHistoryList extends StatelessWidget {
  final Set<Place> searchHistory;
  final VoidCallback? onClearHistoryPressed;
  final ValueSetter<Place>? onHistorySearchItemPressed;
  final ValueSetter<Place>? onDeleteHistorySearchItemPressed;

  const SearchHistoryList({
    super.key,
    required this.searchHistory,
    this.onClearHistoryPressed,
    this.onHistorySearchItemPressed,
    this.onDeleteHistorySearchItemPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SearchedByYouLabel(),
          SearchHistoryItems(
            searchHistory: searchHistory,
            onClearHistoryPressed: onClearHistoryPressed,
            onHistorySearchItemPressed: onHistorySearchItemPressed,
            onDeleteHistorySearchItemPressed: onDeleteHistorySearchItemPressed,
          ),
        ],
      ),
    );
  }
}

/// Заголовок "вы искали".
class _SearchedByYouLabel extends StatelessWidget {
  const _SearchedByYouLabel();

  @override
  Widget build(BuildContext context) {
    return const LabelFieldText(
      AppStrings.searchedByYou,
      padding: EdgeInsets.only(
        left: 16,
        top: 32,
        bottom: 19,
      ),
    );
  }
}
