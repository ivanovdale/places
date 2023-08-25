import 'package:places/core/data/source/database/database.dart';
import 'package:places/features/place_search/data/mapper/search_history_item_mapper.dart';
import 'package:places/features/place_search/domain/model/search_history_item.dart';
import 'package:places/features/place_search/domain/repository/place_search_history_repository.dart';

final class PlaceSearchHistoryDataRepository
    implements PlaceSearchHistoryRepository {
  const PlaceSearchHistoryDataRepository({
    required Database database,
  }) : _database = database;

  final Database _database;

  @override
  Stream<List<SearchHistoryItem>> getSearchHistory() => _database
      .getSearchHistory()
      .map((searchHistory) => searchHistory.toModelList());

  @override
  Future<SearchHistoryItem?> getSearchHistoryItemById(int id) =>
      _database.getSearchHistoryItemById(id).then(
            (value) => value?.toModel(),
          );

  @override
  Future<void> addToSearchHistory(SearchHistoryItem searchHistoryItem) =>
      _database.addToSearchHistory(searchHistoryItem.toCompanion());

  @override
  Future<void> clearSearchHistory() => _database.clearSearchHistory();

  @override
  Future<void> removeFromSearchHistory(int id) =>
      _database.removeFromSearchHistory(id);
}
