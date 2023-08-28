import 'package:places/core/data/source/database/database_impl.dart';
import 'package:places/features/favourite_places/data/dao/favourite_dao.dart';
import 'package:places/features/place_search/data/dao/search_history_item_dao.dart';

abstract interface class Database {
  //# region История поиска.
  Stream<List<SearchHistoryItemDao>> getSearchHistory();

  Future<SearchHistoryItemDao?> getSearchHistoryItemById(int id);

  Future<void> addToSearchHistory(
    SearchHistoryItemsCompanion searchHistoryItem,
  );

  Future<void> removeFromSearchHistory(int id);

  Future<void> clearSearchHistory();

  //# endregion

  //# region Избранное.
  Stream<List<FavouriteDao>> getFavourites();

  Future<FavouriteDao?> getFavouriteById(int id);

  Future<void> addToFavourites(FavouritesCompanion favourite);

  /// [visited] - bool 0 или 1.
  Future<void> updateFavouriteVisited(int id, int visited);

  /// [date] - дата в unix формате.
  Future<void> updateFavouriteDate(int id, int date);

  Future<void> updateFavouritePosition(int id, int position);

  Future<void> deleteFavourite(int id);

//# endregion
}
