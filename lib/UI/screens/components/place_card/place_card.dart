import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/UI/screens/components/place_card/base_place_card.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/helpers/app_assets.dart';

/// Виджет карточки места. Наследуется от [BasePlaceCard].
///
/// Переопределяет поле [actions] - в списке кнопок карточки 1 элемент - кнопка добавления в избранное/удаления из избранного.
/// Также переопределяет поле [showDetails] - для отображения детальной информации о месте.
///
/// Отображает краткую информацию о месте.
///
/// Параметры:
/// * [place] - модель места (обязательный);
/// * [onAddToFavorites] - коллбэк нажатия на добавление в избранное;
/// * [onRemoveFromFavorites] - коллбэк нажатия на удаление из избранного;
class PlaceCard extends BasePlaceCard {
  final VoidCallback onAddToFavorites;
  final VoidCallback onRemoveFromFavorites;

  @override
  late final Widget actions;

  @override
  bool get showDetails => true;

  PlaceCard(
    Place place, {
    Key? key,
    required this.onAddToFavorites,
    required this.onRemoveFromFavorites,
  }) : super(
          place,
          key: key,
        ) {
    actions = _PlaceActions(
      isFavorite: place.isFavorite,
      onAddToFavorites: onAddToFavorites,
      onRemoveFromFavorites: onRemoveFromFavorites,
    );
  }
}

/// Список кнопок для работы с карточкой.
class _PlaceActions extends StatefulWidget {
  final bool isFavorite;
  final VoidCallback onAddToFavorites;
  final VoidCallback onRemoveFromFavorites;

  const _PlaceActions({
    Key? key,
    required this.isFavorite,
    required this.onAddToFavorites,
    required this.onRemoveFromFavorites,
  }) : super(key: key);

  @override
  State<_PlaceActions> createState() => _PlaceActionsState();
}

/// Состояние кнопок.
///
/// Хранит в себе СтримКонтроллер для переключения кнопки "В избранное"/"Убрать из избранного".
class _PlaceActionsState extends State<_PlaceActions> {
  final StreamController<bool> _actionStreamController = StreamController();

  @override
  void initState() {
    super.initState();

    _actionStreamController.add(widget.isFavorite);
  }

  @override
  void dispose() {
    super.dispose();

    _actionStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18.0,
      ),
      child: StreamBuilder<bool>(
        stream: _actionStreamController.stream,
        builder: (context, snapshot) {
          final isFavorite = snapshot.hasData && (snapshot.data ?? false);

          // Переключение кнопок "В избранное"/"Убрать из избранного"
          return isFavorite
              ? InkWell(
                  child: SvgPicture.asset(AppAssets.heartFilled),
                  onTap: _onRemoveFromFavorites,
                )
              : InkWell(
                  child: SvgPicture.asset(AppAssets.heart),
                  onTap: _onAddToFavorites,
                );
        },
      ),
    );
  }

  void _onRemoveFromFavorites() {
    widget.onRemoveFromFavorites();
    _actionStreamController.add(false);
  }

  void _onAddToFavorites() {
    widget.onAddToFavorites();
    _actionStreamController.add(true);
  }
}
