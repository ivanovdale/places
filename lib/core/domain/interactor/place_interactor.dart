import 'dart:async';

import 'package:places/core/domain/model/place.dart';
import 'package:places/core/domain/model/places_filter_request.dart';
import 'package:places/core/domain/repository/geolocation_repository.dart';
import 'package:places/core/domain/repository/place_repository.dart';
import 'package:places/features/favourite_places/domain/repository/favourite_place_repository.dart';
import 'package:places/features/place_filters/domain/place_filters_repository.dart';

/// Интерактор для работы с местами.
class PlaceInteractor {
  /// Репозиторий работы с местами.
  final PlaceRepository _placeRepository;

  final FavouritePlaceRepository _favouritePlaceRepository;

  final PlaceFiltersRepository _placeFiltersRepository;

  final GeolocationRepository _geolocationRepository;

  PlaceInteractor({
    required PlaceRepository placeRepository,
    required FavouritePlaceRepository favouritePlaceRepository,
    required PlaceFiltersRepository placeFiltersRepository,
    required GeolocationRepository geolocationRepository,
  })  : _geolocationRepository = geolocationRepository,
        _placeFiltersRepository = placeFiltersRepository,
        _favouritePlaceRepository = favouritePlaceRepository,
        _placeRepository = placeRepository;

  /// Получает список мест после фильтрации.
  ///
  /// [placesFilterRequest] - фильтр мест,
  /// [useSavedFilters] - использует сохраненные фильтры из репозитория,
  /// [sortByDistance] - сортирует по расстоянию,
  /// [addFavouriteMark] - добавляет пометку добавления в избранное для каждого места.
  Future<List<Place>> getFilteredPlaces({
    PlacesFilterRequest placesFilterRequest = const PlacesFilterRequest(),
    bool useSavedFilters = false,
    bool sortByDistance = false,
    bool addFavouriteMark = false,
  }) async {
    var filterRequest = placesFilterRequest;
    // Используем сохранённые фильтры.
    if (useSavedFilters) {
      final savedFilters = await _placeFiltersRepository.placeFilters.first;
      filterRequest = placesFilterRequest.copyWith(
        typeFilter: savedFilters.types.toList(),
        radius: savedFilters.radius,
      );
    }

    // Используем координаты пользователя для фильтрации.
    final userCoordinates =
        await _geolocationRepository.userCurrentLocation.first;
    filterRequest = filterRequest.copyWith(coordinatePoint: userCoordinates);

    var filteredPlaces =
        await _placeRepository.getFilteredPlaces(filterRequest);

    if (sortByDistance) {
      // Сортировка по удалённости, если есть значение расстояния.
      if (filteredPlaces.isNotEmpty && filteredPlaces[0].distance != null) {
        filteredPlaces
            .sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));
      }
    }

    if (addFavouriteMark) {
      final favouritePlaces =
          await _favouritePlaceRepository.getFavourites().first;
      filteredPlaces = addFavouriteMarks(filteredPlaces, favouritePlaces);
    }

    return filteredPlaces;
  }

  /// Добавляет пометку добавления в избранное для каждого места.
  List<Place> addFavouriteMarks(
    List<Place> places,
    List<Place> favouritePlaces,
  ) {
    for (final place in places) {
      final indexOfFilteredPlace = favouritePlaces
          .indexWhere((favouritePlace) => favouritePlace == place);

      if (indexOfFilteredPlace != -1) {
        place.isFavorite = true;
      } else {
        place.isFavorite = false;
      }
    }

    return places;
  }

  /// Возвращает детали места.
  Future<Place> getPlaceDetails(int id) async {
    final place = await _placeRepository.getPlaceById(id.toString());
    final isInFavourites = await _favouritePlaceRepository
        .getFavouritePlaceById(id)
        .then((value) => value != null);

    if (isInFavourites) {
      place.isFavorite = true;
    }

    return place;
  }

  /// Добавляет новое место.
  Future<Place> addNewPlace(Place place) async {
    return _placeRepository.addNewPlace(place);
  }
}
