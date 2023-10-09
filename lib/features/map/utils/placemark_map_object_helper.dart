import 'package:flutter/cupertino.dart';
import 'package:places/core/domain/model/coordinate_point.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/utils/coordinate_point_ext.dart';
import 'package:places/core/utils/place_ext.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

abstract final class PlacemarkMapObjectHelper {
  static const String _userId = 'user';

  static List<PlacemarkMapObject> getMapObjects({
    required List<Place> places,
    CoordinatePoint? userLocation,
    required bool addUserPlacemark,
    required ValueSetter<Place> onPlacemarkObjectTap,
  }) {
    final mapObjects = places
        .map(
          (place) => place.toPlacemarkMapObject(
            onPlacemarkObjectTap: onPlacemarkObjectTap,
          ),
        )
        .toList();

    if (addUserPlacemark) {
      final userCoordinates = userLocation ?? CoordinatePoint.defaults();
      final userPlacemark = userCoordinates.toPlacemarkMapObject(
        id: _userId,
        imageAssetName: AppAssets.mapUserMark,
      );
      mapObjects.add(userPlacemark);
    }

    return mapObjects;
  }
}
