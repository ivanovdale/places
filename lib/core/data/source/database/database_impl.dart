import 'package:drift/drift.dart';
import 'package:places/core/data/source/database/connection.dart' as impl;
import 'package:places/core/data/source/database/database.dart';
import 'package:places/features/place_search/data/dao/search_history_item_dao.dart';

part 'database_impl.g.dart';

/// Для генерации класса запустить команду
/// dart run build_runner build
@DriftDatabase(include: {'sql/search_history.drift'})
class DatabaseImpl extends _$DatabaseImpl implements Database {
  DatabaseImpl({
    required String dbName,
    required bool logStatements,
  }) : super(
          impl.connect(
            dbName,
            logStatements: logStatements,
          ),
        );

  @override
  int get schemaVersion => 1;

  @override
  Stream<List<SearchHistoryItemDao>> getSearchHistory() =>
      _getSearchHistory().watch();

  @override
  Future<SearchHistoryItemDao?> getSearchHistoryItemById(int id) =>
      _getSearchHistoryItemById(id).getSingleOrNull();

  @override
  Future<void> addToSearchHistory(
    SearchHistoryItemsCompanion searchHistoryItem,
  ) =>
      _insertSearchHistoryItem(
        searchHistoryItem.name.value,
        searchHistoryItem.imageUrl.value,
        searchHistoryItem.placeId.value,
      );

  @override
  Future<void> removeFromSearchHistory(int id) => _deleteSearchHistoryItem(id);

  @override
  Future<void> clearSearchHistory() => transaction(_deleteAllSearchHistory);
}
