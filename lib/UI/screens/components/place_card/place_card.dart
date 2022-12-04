import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/place_card/base_place_card.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/helpers/app_assets.dart';

/// Виджет карточки места. Наследуется от [BasePlaceCard].
///
/// Переопределяет поле [actions] - в списке кнопок карточки 1 элемент - кнопка добавления в избранное.
/// Также переопределяет поле [showDetails] - для отображения детальной информации о месте.
///
/// Отображает краткую информацию о месте.
///
/// Параметры:
/// * [place] - модель места (обязательный);
class PlaceCard extends BasePlaceCard {
  @override
  final List<Map<String, Object?>> actions = [
    {
      'icon': AppAssets.heart,
    },
  ];

  @override
  bool get showDetails => true;

  PlaceCard(
    Place place, {
    Key? key,
  }) : super(
          place,
          key: key,
        );
}
