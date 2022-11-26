import 'dart:convert';

import 'package:places/API/api.dart';
import 'package:places/API/get_new_place_body.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

/// Получает данные мест по сети.
class NetworkPlaceRepository implements PlaceRepository {
  // TODO(daniiliv): doc
  final Api _apiUtil;

  NetworkPlaceRepository(this._apiUtil);

  // TODO(daniiliv): doc
  @override
  Future<Place> addNewPlace(Place place) async {
    final body = GetNewPlaceBody.toApi(place);
    final response =
        await _apiUtil.httpClient.post<String>('/place', data: body);

    // TODO(daniiliv): Нужна обработка ошибок.
    return Place.fromJson(
      jsonDecode(response.data as String) as Map<String, dynamic>,
    );
  }

  // TODO(daniiliv): doc
  @override
  Future<Place> getPlaceById(String id) async {
    final response = await _apiUtil.httpClient.get<String>(
      '/place/$id',
    );

    // TODO(daniiliv): Нужна обработка ошибок.
    return Place.fromJson(
      jsonDecode(response.data as String) as Map<String, dynamic>,
    );
  }

  // TODO(daniiliv): doc
  @override
  Future<List<Place>> getPlaces() async {
    final response = await _apiUtil.httpClient.get<String>('/place');

    // TODO(daniiliv): Обработка ошибок.
    final rawPlacesJSON = (jsonDecode(response.data as String) as List<dynamic>)
        .cast<Map<String, dynamic>>();

    final result = rawPlacesJSON.map(Place.fromJson).toList();

    return result;
  }
}
