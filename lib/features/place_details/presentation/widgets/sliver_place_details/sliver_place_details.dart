import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/presentation/widgets/custom_divider.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_bloc.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_event.dart';
import 'package:places/features/place_details/presentation/widgets/sliver_place_details/components/buttons/build_route_button.dart';
import 'package:places/features/place_details/presentation/widgets/sliver_place_details/components/buttons/place_actions_buttons.dart';
import 'package:places/features/place_details/presentation/widgets/sliver_place_details/components/place_info/place_info.dart';

/// Виджет для отображения нижней части подробностей места.
///
/// Отображает название, тип, режим работы, описание места.
/// Предоставляет возможность построить маршрут к этому месту.
/// Также есть возможность запланировать поход в место и добавить его в список избранного.
///
/// Обязательный параметр конструктора: [place] - модель места.
class SliverPlaceDetails extends StatelessWidget {
  final Place place;

  const SliverPlaceDetails(this.place, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PlaceInfo(place),
            const BuildRouteButton(),
            const CustomDivider(
              padding: EdgeInsets.only(
                top: 24,
                left: 16,
                right: 16,
                bottom: 8,
              ),
              thickness: 0.8,
            ),
            PlaceActionsButtons(
              isPlaceInFavourites: place.isFavorite,
              onFavouritesPressed: () =>
                  context.read<FavouritePlacesBloc>().add(
                        FavouritePlacesToFavouritesPressed(place),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
