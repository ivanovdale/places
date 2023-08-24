import 'package:places/features/place_search/domain/model/search_history_item.dart';

abstract interface class PlaceSearchHistoryRepository {
  Stream<List<SearchHistoryItem>> getSearchHistory();

  Future<SearchHistoryItem?> getSearchHistoryItemById(int placeId);

  Future<void> addToSearchHistory(SearchHistoryItem searchHistoryItem);

  /// [placeId] - id бэкенда.
  Future<void> removeFromSearchHistory(int placeId);

  Future<void> clearSearchHistory();
}
