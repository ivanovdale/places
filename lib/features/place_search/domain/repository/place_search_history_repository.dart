import 'package:places/features/place_search/domain/model/search_history_item.dart';

abstract interface class PlaceSearchHistoryRepository {
  Stream<List<SearchHistoryItem>> getSearchHistory();

  Future<SearchHistoryItem?> getSearchHistoryItemById(int id);

  Future<void> addToSearchHistory(SearchHistoryItem searchHistoryItem);

  /// [id] - id бэкенда.
  Future<void> removeFromSearchHistory(int id);

  Future<void> clearSearchHistory();
}
