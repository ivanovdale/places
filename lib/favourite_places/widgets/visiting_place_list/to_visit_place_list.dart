import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/placeholders/info_placeholder.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/favourite_places/widgets/cards/to_visit_place_card.dart';
import 'package:places/favourite_places/widgets/placeholders/empty_to_visit_placeholder.dart';
import 'package:places/favourite_places/widgets/visiting_place_list/base_visiting_place_list/base_visiting_place_list.dart';
import 'package:places/providers/visiting_provider.dart';

/// Список планируемых к посещению мест. Наследуется от [BaseVisitingPlaceList].
///
/// Если список пуст, будет отображена соответствующая информация ([emptyVisitingList]).
///
/// Переопределяет поля:
/// * [emptyVisitingList] - виджет для отображения пустого списка;
/// * [placeCardType] - тип карточки места.
class ToVisitPlaceList extends BaseVisitingPlaceList {
  @override
  final InfoPlaceHolder emptyVisitingList;

  @override
  final Type placeCardType;

  ToVisitPlaceList(
    VisitingProvider viewModel, {
    Key? key,
  })  : emptyVisitingList = const EmptyToVisitPlaceHolder(),
        placeCardType = ToVisitPlaceCard,
        super(
          listOfPlaces: viewModel.toVisitPlaces,
          viewModel: viewModel,
          key: key,
        );

  @override
  void deletePlaceFromList(Place place) {
    viewModel.removeFromFavorites(place);
  }

  @override
  void insertIntoPlaceList(
    int destinationIndex,
    int placeIndex,
    BuildContext context,
  ) {
    viewModel.insertIntoToVisitPlaceList(destinationIndex, placeIndex);
  }
}
