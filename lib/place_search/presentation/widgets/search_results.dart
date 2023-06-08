import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/place_search/presentation/widgets/places_found_list/components/place_found_item.dart';
import 'package:places/place_search/presentation/widgets/places_found_list/places_found_list.dart';
import 'package:places/place_search/presentation/widgets/search_history/components/delete_history_search_item_from_list_button.dart';
import 'package:places/place_search/presentation/widgets/search_history/components/history_search_item_text_button.dart';
import 'package:places/place_search/presentation/widgets/search_history/search_history.dart';

/// Отображает результаты поиска - историю прошлых поисков или найденные места,
/// если в строке поиска начат ввод текста.
class SearchResults extends StatelessWidget {
  final Set<Place> searchHistory;
  final String searchString;
  final List<Place> placesFoundList;
  final OnPlaceFoundItemPressed? onPlacesFoundItemPressed;
  final bool isSearchStringEmpty;
  final bool isSearchQueryInProgress;
  final VoidCallback? onClearHistoryPressed;
  final OnHistorySearchItemPressed? onHistorySearchItemPressed;
  final OnDeleteHistorySearchItemPressed? onDeleteHistorySearchItemPressed;

  const SearchResults({
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
                SearchHistory(
                  searchHistory: searchHistory,
                  isSearchStringEmpty: isSearchStringEmpty,
                  onClearHistoryPressed: onClearHistoryPressed,
                  onHistorySearchItemPressed: onHistorySearchItemPressed,
                  onDeleteHistorySearchItemPressed:
                      onDeleteHistorySearchItemPressed,
                ),
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
