import 'package:flutter/material.dart';

import 'package:places/domain/model/place.dart';
import 'package:places/features/favourite_places/presentation/widgets/cards/visited_place_card.dart';
import 'package:places/features/favourite_places/presentation/widgets/placeholders/empty_visited_placeholder.dart';
import 'package:places/features/favourite_places/presentation/widgets/visiting_place_list/base_visiting_place_list/base_visiting_place_list.dart';

/// Список посещенных мест. Наследуется от [BaseVisitingPlaceList].
///
/// Если список пуст, будет отображена соответствующая информация ([emptyVisitingList]).
///
/// Переопределяет поля:
/// * [emptyVisitingList] - виджет для отображения пустого списка;
/// * [placeCardType] - тип карточки места.
class VisitedPlaceList extends BaseVisitingPlaceList {
  @override
  WidgetBuilder get emptyVisitingList =>
      (context) => const EmptyVisitedPlaceHolder();

  @override
  Type get placeCardType => VisitedPlaceCard;

  const VisitedPlaceList(
    List<Place> listOfPlaces, {
    OnPlaceDeleted? onPlaceDeleted,
    OnPlaceInserted? onPlaceInserted,
    Key? key,
  }) : super(
          listOfPlaces: listOfPlaces,
          key: key,
          onPlaceDeleted: onPlaceDeleted,
          onPlaceInserted: onPlaceInserted,
        );
}
