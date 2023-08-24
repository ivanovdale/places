import 'package:places/core/data/source/database/database_impl.dart'
    as db;
import 'package:places/features/place_search/data/dao/search_history_item_dao.dart';
import 'package:places/features/place_search/domain/model/search_history_item.dart';

extension SearchHistoryItemMapperExt on SearchHistoryItemDao {
  SearchHistoryItem toModel() => SearchHistoryItem(
        id: placeId,
        name: name,
        imageUrl: imageUrl,
      );
}

extension SearchHistoryItemsMapperExt on List<SearchHistoryItemDao> {
  List<SearchHistoryItem> toModelList() => map((e) => e.toModel()).toList();
}

extension SearchHistoryItemCompanionMapperExt on SearchHistoryItem {
  db.SearchHistoryItemsCompanion toCompanion() =>
      db.SearchHistoryItemsCompanion.insert(
        name: name,
        imageUrl: imageUrl,
        placeId: id,
      );
}
