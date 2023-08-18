import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/presentation/widgets/custom_circular_loading_indicator.dart';
import 'package:places/core/presentation/widgets/place_card/place_card.dart';
import 'package:places/core/presentation/widgets/placeholders/error_placeholder.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_bloc.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_event.dart';
import 'package:places/features/place_list/presentation/bloc/place_list_bloc.dart';

/// Список достопримечательностей на сливере.
class SliverPlaceList extends StatelessWidget {
  const SliverPlaceList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final orientation = mediaQuery.orientation;
    final screenHeight = mediaQuery.size.height;

    return BlocSelector<PlaceListBloc, PlaceListState, PlaceListStatusPlaces>(
      selector: (state) => (status: state.status, places: state.places),
      builder: (_, statusPlaces) => switch (statusPlaces.status) {
        PlaceListStatus.initial => const SliverToBoxAdapter(
            child: SizedBox.shrink(),
          ),
        PlaceListStatus.loading => const SliverFillRemaining(
            child: Center(
              child: CustomCircularLoadingIndicator(),
            ),
          ),
        PlaceListStatus.failure => const SliverFillRemaining(
            child: ErrorPlaceHolder(),
          ),
        PlaceListStatus.success => SliverGrid(
            delegate: SliverChildBuilderDelegate(
              childCount: statusPlaces.places.length,
              (_, index) {
                final place = statusPlaces.places[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: PlaceCard(
                    place,
                    toggleFavorites: () {
                      context.read<FavouritePlacesBloc>().add(
                            FavouritePlacesToFavouritesPressed(place),
                          );
                    },
                  ),
                );
              },
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              // Для горизонтальной ориентации отображаем 2 ряда карточек.
              crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
              mainAxisExtent: orientation == Orientation.portrait
                  ? screenHeight * 0.3
                  : screenHeight * 0.65,
            ),
          ),
      },
    );
  }
}
