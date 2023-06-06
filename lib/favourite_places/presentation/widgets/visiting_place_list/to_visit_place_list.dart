import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/favourite_places/presentation/widgets/cards/to_visit_place_card.dart';
import 'package:places/favourite_places/presentation/widgets/placeholders/empty_to_visit_placeholder.dart';
import 'package:places/favourite_places/presentation/widgets/visiting_place_list/base_visiting_place_list/base_visiting_place_list.dart';

/// Список планируемых к посещению мест. Наследуется от [BaseVisitingPlaceList].
///
/// Если список пуст, будет отображена соответствующая информация ([emptyVisitingList]).
///
/// Переопределяет поля:
/// * [emptyVisitingList] - виджет для отображения пустого списка;
/// * [placeCardType] - тип карточки места.
class ToVisitPlaceList extends BaseVisitingPlaceList {
  @override
  WidgetBuilder get emptyVisitingList =>
      (context) => const EmptyToVisitPlaceHolder();

  @override
  Type get placeCardType => ToVisitPlaceCard;

  const ToVisitPlaceList(
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
