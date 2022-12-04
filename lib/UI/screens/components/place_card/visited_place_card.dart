import 'package:flutter/foundation.dart';
import 'package:places/UI/screens/components/place_card/base_place_card.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/helpers/app_assets.dart';

/// Виджет карточки посещённого места. Наследуется от [BasePlaceCard].
///
/// Переопределяет поле [actions] - в списке кнопок карточки 2 элемента - кнопка удаления из избранного, кнопка календаря.
///
/// Также переопределяет поле [showDetails] - для отображения информации о посещенном месте.
///
/// Имеет параметры:
/// * [place] - модель места (обязательный);
class VisitedPlaceCard extends BasePlaceCard {
  final VoidCallback? onSharePressed;
  final VoidCallback? onDeletePressed;

  @override
  late final List<Map<String, Object?>> actions;

  @override
  bool get showDetails => false;

  VisitedPlaceCard(
    Place place, {
    this.onSharePressed,
    this.onDeletePressed,
    Key? key,
  }) : super(
          place,
          key: key,
        ) {
    actions = [
      {
        'icon': AppAssets.share,
        'voidCallback': onSharePressed,
      },
      {
        'icon': AppAssets.close,
        'voidCallback': onDeletePressed,
      },
    ];
  }
}
