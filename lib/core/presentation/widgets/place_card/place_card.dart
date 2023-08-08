import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/presentation/widgets/place_card/base_place_card.dart';
import 'package:places/core/presentation/widgets/place_card/cubit/place_card_favourite_cubit.dart';

/// Виджет карточки места. Наследуется от [BasePlaceCard].
///
/// Переопределяет поле [actions] - в списке кнопок карточки 1 элемент - кнопка добавления в избранное/удаления из избранного.
/// Также переопределяет поле [showDetails] - для отображения детальной информации о месте.
///
/// Отображает краткую информацию о месте.
///
/// Параметры:
/// * [place] - модель места (обязательный);
/// * [toggleFavorites] - коллбэк нажатия на добавление в избранное / удаление из избранного.
class PlaceCard extends BasePlaceCard {
  final VoidCallback toggleFavorites;

  @override
  final Widget actions;

  @override
  bool get showDetails => true;

  PlaceCard(
    super.place, {
    super.key,
    required this.toggleFavorites,
  }) : actions = _PlaceActions(
          isFavorite: place.isFavorite,
          toggleFavorites: toggleFavorites,
        );
}

/// Список кнопок для работы с карточкой.
class _PlaceActions extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback toggleFavorites;

  const _PlaceActions({
    required this.isFavorite,
    required this.toggleFavorites,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18,
      ),
      child: BlocProvider(
        create: (_) => PlaceCardFavouriteCubit(
          initialValue: isFavorite,
          toggleFavoritesCallback: toggleFavorites,
        ),
        child: BlocBuilder<PlaceCardFavouriteCubit, PlaceCardFavouriteState>(
          builder: (context, state) {
            return InkWell(
              child: SvgPicture.asset(
                state.isFavourite ? AppAssets.heartFilled : AppAssets.heart,
              ),
              onTap: () =>
                  context.read<PlaceCardFavouriteCubit>().toggleFavorites(),
            );
          },
        ),
      ),
    );
  }
}
