import 'package:drift/drift.dart';
import 'package:places/core/data/source/database/database_impl.dart';
import 'package:places/core/domain/model/coordinate_point.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/favourite_places/data/dao/favourite_dao.dart';

extension FavouriteMapperExt on FavouriteDao {
  Place toModel() => Place(
        id: id,
        name: name,
        coordinatePoint: CoordinatePoint.empty(),
        details: '',
        type: PlaceTypes.fromString(type),
        visitDate: date != null
            ? DateTime.fromMillisecondsSinceEpoch(date!).toLocal()
            : null,
        visited: visited == 1,
        photoUrlList: [imageUrl],
        position: position,
      );
}

extension FavouriteListMapperExt on List<FavouriteDao> {
  List<Place> toModelList() => map((favourite) => favourite.toModel()).toList();
}

extension SearchHistoryItemCompanionMapperExt on Place {
  FavouritesCompanion toCompanion() => FavouritesCompanion.insert(
        id: Value<int>(id!),
        name: name,
        imageUrl: photoUrlList?.first ?? '',
        type: type.name,
        visited: visited ? 1 : 0,
        position: 0,
      );
}
