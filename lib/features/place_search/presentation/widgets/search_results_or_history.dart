import 'package:flutter/material.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/place_search/presentation/widgets/places_found_list/places_found_list.dart';
import 'package:places/features/place_search/presentation/widgets/search_history_list/search_history_list.dart';

/// Отображает результаты поиска - историю прошлых поисков или найденные места,
/// если в строке поиска начат ввод текста.
class SearchResultsOrHistory extends StatelessWidget {
  final Set<Place> searchHistory;
  final String searchString;
  final List<Place> placesFoundList;
  final ValueSetter<Place>? onPlacesFoundItemPressed;
  final bool isSearchStringEmpty;
  final bool isSearchQueryInProgress;
  final VoidCallback? onClearHistoryPressed;
  final ValueSetter<Place>? onHistorySearchItemPressed;
  final ValueSetter<Place>? onDeleteHistorySearchItemPressed;

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
                // Показывать историю поиска, если она заполнена, и если строка поиска пуста.
                if (searchHistory.isNotEmpty && isSearchStringEmpty)
                  SearchHistoryList(
                    searchHistory: searchHistory,
                    onClearHistoryPressed: onClearHistoryPressed,
                    onHistorySearchItemPressed: onHistorySearchItemPressed,
                    onDeleteHistorySearchItemPressed:
                        onDeleteHistorySearchItemPressed,
                  ),
                // Показывать список найденных мест, если строка поиска заполнена.
                if (!isSearchStringEmpty)
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
