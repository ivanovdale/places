import 'dart:convert';

import 'package:places/core/api/dio_api.dart';
import 'package:places/core/api/dio_query_util.dart';
import 'package:places/core/data/dto/place_dto.dart';
import 'package:places/core/data/repository/place_mapper.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/domain/model/places_filter_request.dart';
import 'package:places/core/domain/repository/place_repository.dart';

/// Получает данные мест по сети.
class NetworkPlaceRepository implements PlaceRepository {
  // Клиент для работы с АПИ.
  final DioApi _apiUtil;

  NetworkPlaceRepository(
    this._apiUtil,
  );

  /// Добавляет новое место в список мест.
  ///
  /// Возвращает добавленное место.
  @override
  Future<Place> addNewPlace(Place place) async {
    final placeDto = PlaceMapper.placeToDto(place);
    final body = jsonEncode(placeDto.toJson());
    final response = await DioQueryUtil.handleQuery(
      _apiUtil,
      requestType: RequestType.post,
      uri: '/place',
      data: body,
    );
    final newPlaceDto = PlaceDTO.fromJson(
      jsonDecode(response.data!) as Map<String, dynamic>,
    );

    return PlaceMapper.placeFromDto(newPlaceDto);
  }

  /// Получает место по id.
  @override
  Future<Place> getPlaceById(String id) async {
    final uri = '/place/$id';
    final response = await DioQueryUtil.handleQuery(
      _apiUtil,
      requestType: RequestType.get,
      uri: uri,
    );
    final placeDto = PlaceDTO.fromJson(
      jsonDecode(response.data!) as Map<String, dynamic>,
    );

    return PlaceMapper.placeFromDto(placeDto);
  }

  /// Получает список всех мест.
  @override
  Future<List<Place>> getPlaces() async {
    final response = await DioQueryUtil.handleQuery(
      _apiUtil,
      requestType: RequestType.get,
      uri: '/place',
    );
    final rawPlacesJson = (jsonDecode(response.data!) as List<dynamic>)
        .cast<Map<String, dynamic>>();
    final placeList = rawPlacesJson
        .map((rawPlaceJson) =>
            PlaceMapper.placeFromDto(PlaceDTO.fromJson(rawPlaceJson)))
        .toList();

    return placeList;
  }

  /// Получает отфильтрованный список мест.
  @override
  Future<List<Place>> getFilteredPlaces(
    PlacesFilterRequest placesFilterRequest,
  ) async {
    final placesFilterRequestDto = placesFilterRequest.toDto();
    final body = jsonEncode(placesFilterRequestDto.toJson());
    final response = await DioQueryUtil.handleQuery(
      _apiUtil,
      requestType: RequestType.post,
      uri: '/filtered_places',
      data: body,
    );
    final rawPlacesJson = (jsonDecode(response.data!) as List<dynamic>)
        .cast<Map<String, dynamic>>();
    final placeList = rawPlacesJson
        .map((rawPlaceJson) =>
            PlaceMapper.placeFromDto(PlaceDTO.fromJson(rawPlaceJson)))
        .toList();

    return placeList;
  }
}
