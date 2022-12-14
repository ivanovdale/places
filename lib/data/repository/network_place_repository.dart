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
  final List<Place> _favoritePlaces = [];

  NetworkPlaceRepository(
    this._apiUtil,
  );

  /// Добавляет новое место в список мест.
  ///
  /// Возвращает добавленное место.
  @override
  Future<PlaceDTO> addNewPlace(PlaceDTO placeDto) async {
    final body = jsonEncode(placeDto.toJson());
    final response =
        await _apiUtil.httpClient.post<String>('/place', data: body);

    // TODO(daniiliv): Тех.долг - нужна обработка ошибок.
    final newPlaceDto = PlaceDTO.fromJson(
      jsonDecode(response.data as String) as Map<String, dynamic>,
    );

    return newPlaceDto;
  }

  /// Получает место по id.
  @override
  Future<PlaceDTO> getPlaceById(String id) async {
    final response = await _apiUtil.httpClient.get<String>(
      '/place/$id',
    );

    // TODO(daniiliv): Тех.долг - нужна обработка ошибок.
    final placeDto = PlaceDTO.fromJson(
      jsonDecode(response.data as String) as Map<String, dynamic>,
    );

    return placeDto;
  }

  /// Получает список всех мест.
  @override
  Future<List<PlaceDTO>> getPlaces() async {
    final response = await _apiUtil.httpClient.get<String>('/place');

    // TODO(daniiliv): Тех.долг - нужна обработка ошибок.
    final rawPlacesJSON = (jsonDecode(response.data as String) as List<dynamic>)
        .cast<Map<String, dynamic>>();

    final placeDtoList = rawPlacesJSON.map(PlaceDTO.fromJson).toList();

    return placeDtoList;
  }

  /// Получает отфильтрованный список мест.
  @override
  Future<List<PlaceDTO>> getFilteredPlaces(
    PlacesFilterRequestDto placesFilterRequestDto,
  ) async {
    final body = jsonEncode(placesFilterRequestDto.toJson());
    final response =
        await _apiUtil.httpClient.post<String>('/filtered_places', data: body);

    // TODO(daniiliv): Тех.долг - нужна обработка ошибок.
    final rawPlacesJSON = (jsonDecode(response.data as String) as List<dynamic>)
        .cast<Map<String, dynamic>>();

    final placeDtoList = rawPlacesJSON.map(PlaceDTO.fromJson).toList();

    return placeDtoList;
  }

  /// Добавляет место в список избранных и делает пометку объекту, что место в избранном.
  @override
  void addToFavorites(Place place) {
    _favoritePlaces.add(place);
    place.isFavorite = true;
  }

  /// Удаляет место из списка избранных и снимает пометку объекту, что место в избранном.
  @override
  void removeFromFavorites(Place place) {
    _favoritePlaces.remove(place);
    place.isFavorite = false;
  }

  /// Возвращает список мест, планируемых к посещению.
  @override
  List<Place> getFavoritePlaces() {
    return _favoritePlaces.where((place) => !place.visited).toList();
  }

  /// Возвращает список посещенных мест.
  @override
  List<Place> getVisitedPlaces() {
    return _favoritePlaces.where((place) => place.visited).toList();
  }

  /// Делает пометку, что место посещено.
  @override
  void addToVisitedPlaces(Place place) {
    place.visited = true;
  }
}