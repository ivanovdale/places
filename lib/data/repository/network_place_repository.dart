import 'dart:convert';

import 'package:places/API/api.dart';
import 'package:places/API/get_new_place_body.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';

/// Получает данные мест по сети.
class NetworkPlaceRepository implements PlaceRepository {
  final Api _apiUtil;

  NetworkPlaceRepository(this._apiUtil);

  @override
  Future<Place> addNewPlace(Place place) async {
    final body = GetNewPlaceBody.toApi(place);
    final result = await _apiUtil.httpClient.post<String>('/place', data: body);

    // TODO(daniiliv): Нужна обработка ошибок.
    return Place.fromJson(
      jsonDecode(result.data as String) as Map<String, dynamic>,
    );
  }

  @override
  Future<Place> getPlaceById(String id) {
    // TODO: implement getPlaceById
    throw UnimplementedError();
  }

  @override
  Future<List<Place>> getPlaces() {
    // TODO: implement getPlaces
    throw UnimplementedError();
  }
}
