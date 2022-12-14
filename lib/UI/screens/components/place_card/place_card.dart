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
/// * [onAddToFavorites] - коллбэк нажатия на добавление в избранное;
/// * [onRemoveFromFavorites] - коллбэк нажатия на удаление из избранного;
class PlaceCard extends BasePlaceCard {
  final VoidCallback? onAddToFavorites;
  final VoidCallback? onRemoveFromFavorites;

  @override
  late final List<Map<String, Object?>> actions;

  @override
  bool get showDetails => true;

  PlaceCard(
    Place place, {
    Key? key,
    this.onAddToFavorites,
    this.onRemoveFromFavorites,
  }) : super(
          place,
          key: key,
        ) {
    actions = place.isFavorite
        ? [
            {
              'icon': AppAssets.heartFilled,
              'voidCallback': onRemoveFromFavorites,
            },
          ]
        : [
            {
              'icon': AppAssets.heart,
              'voidCallback': onAddToFavorites,
            },
          ];
  }
}
