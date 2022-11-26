import 'package:flutter/foundation.dart';
import 'package:places/UI/screens/components/place_card/base_place_card.dart';
import 'package:places/data/model/place.dart';
import 'package:places/helpers/app_assets.dart';

/// Виджет карточки места, которую планируется посетить. Наследуется от [BasePlaceCard].
///
/// Переопределяет поле [actions] - в списке кнопок карточки 2 элемента - кнопка удаления из избранного, кнопка календаря.
/// Также переопределяет поле [showDetails] - для отображения информации о планируемом посещении места.
///
/// Имеет параметры:
/// * [place] - модель места (обязательный);
class ToVisitPlaceCard extends BasePlaceCard {
  final VoidCallback? onCalendarPressed;
  final VoidCallback? onDeletePressed;

  @override
  late final List<Map<String, Object?>> actions;

  @override
  bool get showDetails => false;

  ToVisitPlaceCard(
      Place place, {
        this.onCalendarPressed,
        this.onDeletePressed,
        Key? key,
      }) : super(
    place,
    key: key,
  ) {
    actions = [
      {
        'icon': AppAssets.calendar,
        'voidCallback': onCalendarPressed,
      },
      {
        'icon': AppAssets.close,
        'voidCallback': onDeletePressed,
      },
    ];
  }
}