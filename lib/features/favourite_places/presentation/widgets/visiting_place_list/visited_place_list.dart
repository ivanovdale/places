import 'package:flutter/material.dart';

import 'package:places/core/domain/model/place.dart';
import 'package:places/features/favourite_places/presentation/widgets/placeholders/empty_visited_placeholder.dart';
import 'package:places/features/favourite_places/presentation/widgets/visiting_place_list/base_visiting_place_list/base_visiting_place_list.dart';

/// Список посещенных мест. Наследуется от [BaseVisitingPlaceList].
///
/// Если список пуст, будет отображена соответствующая информация ([emptyVisitingList]).
///
/// Переопределяет поля:
/// * [emptyVisitingList] - виджет для отображения пустого списка.
class VisitedPlaceList extends BaseVisitingPlaceList {
  @override
  WidgetBuilder get emptyVisitingList =>
      (context) => const EmptyVisitedPlaceHolder();

  const VisitedPlaceList(
    List<Place> listOfPlaces, {
    super.onPlaceDeleted,
    super.onPlaceInserted,
    super.key,
  }) : super(
          listOfPlaces: listOfPlaces,
        );
}
