import 'dart:async';

import 'package:places/core/domain/model/place.dart';
import 'package:places/core/domain/model/places_filter_request.dart';
import 'package:places/core/domain/repository/place_repository.dart';
import 'package:places/features/favourite_places/domain/favourite_place_repository.dart';
import 'package:places/features/place_filters/domain/place_filters_repository.dart';

/// Интерактор для работы с местами.
class PlaceInteractor {
  /// Репозиторий работы с местами.
  final PlaceRepository placeRepository;

  final FavouritePlaceRepository favouritePlaceRepository;

  final PlaceFiltersRepository placeFiltersRepository;

  PlaceInteractor({
    required this.placeRepository,
    required this.favouritePlaceRepository,
    required this.placeFiltersRepository,
  });

  /// Получает список мест после фильтрации.
  ///
  /// [placesFilterRequest] - фильтр мест,
  /// [useSavedFilters] - использует сохраненные фильтры из репозитория,
  /// [sortByDistance] - сортирует по расстоянию,
  /// [addFavouriteMark] - добавляет пометку добавления в избранное для каждого места.
  Future<List<Place>> getFilteredPlaces(
    PlacesFilterRequest placesFilterRequest, {
    bool useSavedFilters = false,
    bool sortByDistance = false,
    bool addFavouriteMark = false,
  }) async {
    var filterRequest = placesFilterRequest;
    if (useSavedFilters) {
      final savedFilters = await placeFiltersRepository.placeFilters.first;
      filterRequest = placesFilterRequest.copyWith(
        typeFilter: savedFilters.types.toList(),
        radius: savedFilters.radius,
      );
    }

    final filteredPlaces =
        await placeRepository.getFilteredPlaces(filterRequest);

    if (sortByDistance) {
      // Сортировка по удалённости, если есть значение расстояния.
      if (filteredPlaces.isNotEmpty && filteredPlaces[0].distance != null) {
        filteredPlaces
            .sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));
      }
    }

    if (addFavouriteMark) {
      // Добавляем пометку добавления в избранное для каждого места.
      final favouritePlaces = favouritePlaceRepository.getPlaces();
      for (final favouritePlace in favouritePlaces) {
        final indexOfFilteredPlace = filteredPlaces
            .indexWhere((filteredPlace) => filteredPlace == favouritePlace);

        if (indexOfFilteredPlace == -1) continue;

        filteredPlaces[indexOfFilteredPlace].isFavorite = true;
      }
    }

    return filteredPlaces;
  }

  /// Возвращает детали места.
  Future<Place> getPlaceDetails(int id) async {
    return placeRepository.getPlaceById(id.toString());
  }

  /// Добавляет новое место.
  Future<Place> addNewPlace(Place place) async {
    return placeRepository.addNewPlace(place);
  }
}
