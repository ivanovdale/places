import 'package:places/core/data/source/database/database_impl.dart';
import 'package:places/features/place_search/data/dao/search_history_item_dao.dart';

abstract interface class Database {
  Stream<List<SearchHistoryItemDao>> getSearchHistory();

  Future<SearchHistoryItemDao?> getSearchHistoryItemById(int id);

  Future<void> addToSearchHistory(
    SearchHistoryItemsCompanion searchHistoryItem,
  );

  Future<void> removeFromSearchHistory(int id);

  Future<void> clearSearchHistory();
}
