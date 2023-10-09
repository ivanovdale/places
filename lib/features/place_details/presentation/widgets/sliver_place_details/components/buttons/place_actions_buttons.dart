import 'package:flutter/material.dart';
import 'package:places/features/place_details/presentation/widgets/sliver_place_details/components/buttons/to_favourites_button.dart';
import 'package:places/features/place_details/presentation/widgets/sliver_place_details/components/buttons/to_plan_button.dart';

/// Виджет для отображения кнопок для работы с местом.
///
/// Предоставляет возможность запланировать поход в место и добавить его в список избранного.
class PlaceActionsButtons extends StatelessWidget {
  final VoidCallback onFavouritesPressed;
  final bool isPlaceInFavourites;

  const PlaceActionsButtons({
    super.key,
    required this.onFavouritesPressed,
    required this.isPlaceInFavourites,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: ToPlanButton(),
        ),
        Expanded(
          child: ToFromFavouritesButton(
            onPressed: onFavouritesPressed,
            isInFavourites: isPlaceInFavourites,
          ),
        ),
      ],
    );
  }
}
