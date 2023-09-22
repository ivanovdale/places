import 'package:places/core/domain/model/coordinate_point.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

extension CoordinatePointExt on CoordinatePoint {
  Point toPoint() => Point(latitude: lat, longitude: lon);

  PlacemarkMapObject toPlacemarkMapObject({
    required String id,
    required String imageAssetName,
  }) =>
      PlacemarkMapObject(
        mapId: MapObjectId(id),
        point: toPoint(),
        opacity: 1,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(
              imageAssetName,
            ),
          ),
        ),
      );
}
