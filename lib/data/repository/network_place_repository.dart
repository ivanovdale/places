import 'dart:convert';

import 'package:places/API/dio_api.dart';
import 'package:places/data/dto/place_dto.dart';
import 'package:places/data/dto/places_filter_request_dto.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/model/place.dart';

/// Получает данные мест по сети.
class NetworkPlaceRepository implements PlaceRepository {
  // Клиент для работы с АПИ.
  final DioApi _apiUtil;

  // Список избранных мест пользователя.
  final List<Place> _favoritePlaces;

  NetworkPlaceRepository(
    this._apiUtil,
    this._favoritePlaces,
  );

  /// Добавляет новое место в список мест.
  ///
  /// Возвращает добавленное место.
  @override
  Future<Place> addNewPlace(Place place) async {
    final body = jsonEncode(place.toDto().toJson());
    final response =
        await _apiUtil.httpClient.post<String>('/place', data: body);

    // TODO(daniiliv): Нужна обработка ошибок.
    final placeDto = PlaceDTO.fromJson(
      jsonDecode(response.data as String) as Map<String, dynamic>,
    );

    return Place.fromDto(placeDto);
  }

  /// Получает место по id.
  @override
  Future<Place> getPlaceById(String id) async {
    final response = await _apiUtil.httpClient.get<String>(
      '/place/$id',
    );

    // TODO(daniiliv): Нужна обработка ошибок.
    final placeDto = PlaceDTO.fromJson(
      jsonDecode(response.data as String) as Map<String, dynamic>,
    );

    return Place.fromDto(placeDto);
  }

  /// Получает список всех мест.
  @override
  Future<List<Place>> getPlaces() async {
    final response = await _apiUtil.httpClient.get<String>('/place');

    // TODO(daniiliv): Обработка ошибок.
    final rawPlacesJSON = (jsonDecode(response.data as String) as List<dynamic>)
        .cast<Map<String, dynamic>>();

    final placeDtoList = rawPlacesJSON.map(PlaceDTO.fromJson).toList();

    return placeDtoList.map(Place.fromDto).toList();
  }

  /// Получает отфильтрованный список мест.
  @override
  Future<List<Place>> getFilteredPlaces(
    PlacesFilterRequestDto placesFilterRequestDto,
  ) async {
    final body = jsonEncode(placesFilterRequestDto.toJson());
    final response =
        await _apiUtil.httpClient.post<String>('/filtered_places', data: body);

    // TODO(daniiliv): Нужна обработка ошибок.
    final rawPlacesJSON = (jsonDecode(response.data as String) as List<dynamic>)
        .cast<Map<String, dynamic>>();

    final placeDtoList = rawPlacesJSON.map(PlaceDTO.fromJson).toList();

    return placeDtoList.map(Place.fromDto).toList();
  }

  // TODO(daniiliv): doc
  @override
  Future<List<Place>> getFavoritePlaces() async {
    return _favoritePlaces;
  }

  // TODO(daniiliv): doc
  @override
  Future<void> addToFavorites(Place place) async {
    _favoritePlaces.add(place);
  }

  // TODO(daniiliv): doc
  @override
  Future<void> removeFromFavorites(Place place) async {
    _favoritePlaces.remove(place);
  }

  // TODO(daniiliv): doc
  @override
  Future<List<Place>> getVisitedPlaces() async {
    return _favoritePlaces.where((place) => place.visited).toList();
  }

  // TODO(daniiliv): doc
  @override
  Future<void> addToVisitedPlaces(Place place) async {
    place.visited = true;
  }
}
