import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_bloc.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_event.dart';
import 'package:places/features/map/presentation/chosen_place_cubit/chosen_place_cubit.dart';
import 'package:places/features/map/presentation/widgets/map_place_card.dart';

class ChosenPlaceCard extends StatelessWidget {
  const ChosenPlaceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChosenPlaceCubit, ChosenPlaceState>(
      builder: (_, state) {
        final place = state.place;

        return Positioned(
          bottom: 0,
          right: 16,
          left: 16,
          child: AnimatedOpacity(
            opacity: state.isPlaceChosen ? 1 : 0,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: place != null
                ? MapPlaceCard(
                    key: ValueKey(place.id),
                    place,
                    toggleFavorites: () {
                      context.read<FavouritePlacesBloc>().add(
                            FavouritePlacesToFavouritesPressed(place),
                          );
                    },
                    onBuildRoutePressed: () {},
                  )
                : const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
