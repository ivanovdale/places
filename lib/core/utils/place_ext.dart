import 'package:flutter/foundation.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/utils/coordinate_point_ext.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

extension PlaceExt on Place {
  PlacemarkMapObject toPlacemarkMapObject({
    required ValueSetter<Place> onPlacemarkObjectTap,
  }) =>
      PlacemarkMapObject(
        mapId: MapObjectId(id!.toString()),
        point: coordinatePoint.toPoint(),
        opacity: 1,
        onTap: (mapObject, point) => onPlacemarkObjectTap(this),
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(
              AppAssets.mapPlaceDot,
            ),
          ),
        ),
      );
}
