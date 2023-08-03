import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/features/favourite_places/presentation/widgets/placeholders/empty_to_visit_placeholder.dart';
import 'package:places/features/favourite_places/presentation/widgets/visiting_place_list/base_visiting_place_list/base_visiting_place_list.dart';

/// Список планируемых к посещению мест. Наследуется от [BaseVisitingPlaceList].
///
/// Если список пуст, будет отображена соответствующая информация ([emptyVisitingList]).
///
/// Переопределяет поля:
/// * [emptyVisitingList] - виджет для отображения пустого списка.
class ToVisitPlaceList extends BaseVisitingPlaceList {
  final void Function(BuildContext, DateTime) onPlaceDateTimePicked;

  @override
  WidgetBuilder get emptyVisitingList =>
      (context) => const EmptyToVisitPlaceHolder();

  const ToVisitPlaceList(
    List<Place> listOfPlaces, {
    OnPlaceDeleted? onPlaceDeleted,
    OnPlaceInserted? onPlaceInserted,
    required this.onPlaceDateTimePicked,
    Key? key,
  }) : super(
          listOfPlaces: listOfPlaces,
          key: key,
          onPlaceDeleted: onPlaceDeleted,
          onPlaceInserted: onPlaceInserted,
        );
}
