import 'package:places/features/place_search/domain/model/search_history_item.dart';
import 'package:places/features/place_search/domain/repository/place_search_history_repository.dart';

final class PlaceSearchHistoryInteractor {
  const PlaceSearchHistoryInteractor({
    required PlaceSearchHistoryRepository placeSearchHistoryRepository,
  }) : _placeSearchHistoryRepository = placeSearchHistoryRepository;

  final PlaceSearchHistoryRepository _placeSearchHistoryRepository;

  Stream<List<SearchHistoryItem>> getSearchHistory() =>
      _placeSearchHistoryRepository.getSearchHistory();

  Future<SearchHistoryItem?> getSearchHistoryItemById(int id) =>
      _placeSearchHistoryRepository.getSearchHistoryItemById(id);

  Future<void> addToSearchHistory(SearchHistoryItem searchHistoryItem) =>
      _placeSearchHistoryRepository.addToSearchHistory(searchHistoryItem);

  Future<void> removeFromSearchHistory(int id) =>
      _placeSearchHistoryRepository.removeFromSearchHistory(id);

  Future<void> clearSearchHistory() =>
      _placeSearchHistoryRepository.clearSearchHistory();
}
