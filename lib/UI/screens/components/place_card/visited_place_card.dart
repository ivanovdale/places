import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/UI/screens/components/place_card/base_place_card.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/helpers/app_assets.dart';

/// Виджет карточки посещённого места. Наследуется от [BasePlaceCard].
///
/// Переопределяет поле [actions] - в списке кнопок карточки 2 элемента - кнопка удаления из избранного, кнопка "поделиться".
///
/// Также переопределяет поле [showDetails] - для отображения информации о посещенном месте.
///
/// Имеет параметры:
/// * [place] - модель места (обязательный);
class VisitedPlaceCard extends BasePlaceCard {
  final VoidCallback onSharePressed;
  final VoidCallback onDeletePressed;

  @override
  final Widget actions;

  @override
  bool get showDetails => false;

  VisitedPlaceCard(
    Place place, {
    required this.onSharePressed,
    required this.onDeletePressed,
    Key? key,
  })  : actions = _PlaceActions(
          onSharePressed: onSharePressed,
          onDeletePressed: onDeletePressed,
        ),
        super(
          place,
          key: key,
        );
}

/// Список кнопок для работы с карточкой.
class _PlaceActions extends StatelessWidget {
  final VoidCallback onSharePressed;
  final VoidCallback onDeletePressed;

  const _PlaceActions({
    Key? key,
    required this.onSharePressed,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actionButtons = [
      InkWell(
        child: SvgPicture.asset(AppAssets.share),
        onTap: onSharePressed,
      ),
      InkWell(
        child: SvgPicture.asset(AppAssets.close),
        onTap: onDeletePressed,
      ),
    ];

    return Row(
      children: actionButtons.map((action) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 18.0,
          ),
          child: action,
        );
      }).toList(),
    );
  }
}
