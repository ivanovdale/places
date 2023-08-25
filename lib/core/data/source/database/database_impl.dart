import 'package:drift/drift.dart';
import 'package:places/core/data/source/database/connection.dart' as impl;
import 'package:places/core/data/source/database/database.dart';
import 'package:places/features/favourite_places/data/dao/favourite_dao.dart';
import 'package:places/features/place_search/data/dao/search_history_item_dao.dart';

part 'database_impl.g.dart';

/// Для генерации класса запустить команду
/// dart run build_runner build
@DriftDatabase(include: {'sql/search_history.drift', 'sql/favourites.drift'})
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
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from == 2) {
            await migrator.createTable(favourites);
          }
        },
      );

  //# region История поиска.
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
        searchHistoryItem.id.value,
        searchHistoryItem.name.value,
        searchHistoryItem.imageUrl.value,
      );

  @override
  Future<void> removeFromSearchHistory(int id) => _deleteSearchHistoryItem(id);

  @override
  Future<void> clearSearchHistory() => transaction(_deleteAllSearchHistory);

  //# endregion

  //# region Избранное.
  @override
  Stream<List<FavouriteDao>> getFavourites() => _getFavourites().watch();

  @override
  Future<FavouriteDao?> getFavouriteById(int id) =>
      _getFavouriteById(id).getSingleOrNull();

  @override
  Future<void> addToFavourites(FavouritesCompanion favourite) =>
      _insertFavourite(
        favourite.id.value,
        favourite.name.value,
        favourite.imageUrl.value,
        favourite.type.value,
        favourite.date.value,
        favourite.visited.value,
      );

  @override
  Future<void> updateFavouriteVisited(int id, int visited) =>
      transaction(() => _updateFavouriteVisited(visited, id));

  @override
  Future<void> updateFavouriteDate(int id, int date) =>
      transaction(() => _updateFavouriteDate(date, id));

  @override
  Future<void> updateFavouritePosition(int id, int position) =>
      transaction(() => _updateFavouritePosition(position, id));

  @override
  Future<void> deleteFavourite(int id) => _deleteFavourite(id);

//# endregion
}
