import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:places/core/presentation/widgets/place_card/place_card.dart';
import 'package:places/core/presentation/widgets/placeholders/error_placeholder.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_bloc.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_event.dart';
import 'package:places/stores/place_list_store/place_list_store_base.dart';
import 'package:provider/provider.dart';

/// Список достопримечательностей на сливере.
class SliverPlaceList extends StatelessWidget {
  const SliverPlaceList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final orientation = mediaQuery.orientation;
    final screenHeight = mediaQuery.size.height;

    return Observer(
      builder: (_) {
        final store = context.read<PlaceListStore>();
        final isLoading = store.placesFuture?.status == FutureStatus.pending;
        final hasError = store.placesFuture?.error != null;

        if (!isLoading && !hasError) {
          final places = store.placesFuture?.value;

          return SliverGrid(
            delegate: SliverChildBuilderDelegate(
              childCount: places!.length,
                  (_, index) {
                final place = places[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: PlaceCard(
                    place,
                    toggleFavorites: () {
                      context.read<FavouritePlacesBloc>().add(
                        ToggleFavouritesEvent(place),
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
          );
        } else if (hasError) {
          return const SliverFillRemaining(
            child: ErrorPlaceHolder(),
          );
        } else {
          return const SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
