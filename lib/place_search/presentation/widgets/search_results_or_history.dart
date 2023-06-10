import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/place_search/presentation/widgets/places_found_list/components/place_found_item.dart';
import 'package:places/place_search/presentation/widgets/places_found_list/places_found_list.dart';
import 'package:places/place_search/presentation/widgets/search_history_list/components/delete_history_search_item_from_list_button.dart';
import 'package:places/place_search/presentation/widgets/search_history_list/components/history_search_item_text_button.dart';
import 'package:places/place_search/presentation/widgets/search_history_list/search_history_list.dart';

/// Отображает результаты поиска - историю прошлых поисков или найденные места,
/// если в строке поиска начат ввод текста.
class SearchResultsOrHistory extends StatelessWidget {
  final Set<Place> searchHistory;
  final String searchString;
  final List<Place> placesFoundList;
  final OnPlaceFoundItemPressed? onPlacesFoundItemPressed;
  final bool isSearchStringEmpty;
  final bool isSearchQueryInProgress;
  final VoidCallback? onClearHistoryPressed;
  final OnHistorySearchItemPressed? onHistorySearchItemPressed;
  final OnDeleteHistorySearchItemPressed? onDeleteHistorySearchItemPressed;

  const SearchResultsOrHistory({
    Key? key,
    required this.searchHistory,
    required this.placesFoundList,
    this.onPlacesFoundItemPressed,
    required this.isSearchStringEmpty,
    this.onClearHistoryPressed,
    this.onHistorySearchItemPressed,
    this.onDeleteHistorySearchItemPressed,
    required this.searchString,
    required this.isSearchQueryInProgress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isSearchQueryInProgress
        ? Expanded(
            flex: 10,
            child: Column(
              children: [
                // Не показывать историю поиска, если она пуста, или если начат поиск мест.
                if (searchHistory.isNotEmpty && isSearchStringEmpty)
                  SearchHistoryList(
                    searchHistory: searchHistory,
                    onClearHistoryPressed: onClearHistoryPressed,
                    onHistorySearchItemPressed: onHistorySearchItemPressed,
                    onDeleteHistorySearchItemPressed:
                        onDeleteHistorySearchItemPressed,
                  ),
                // Не показывать список найденных мест, если ещё не начат их поиск.
                if (searchString.isNotEmpty)
                  PlacesFoundList(
                    placesFoundList: placesFoundList,
                    searchString: searchString,
                    onPlacesFoundItemPressed: onPlacesFoundItemPressed,
                  ),
              ],
            ),
          )
        : const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
