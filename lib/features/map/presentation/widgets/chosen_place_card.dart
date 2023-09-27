import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_bloc.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_event.dart';
import 'package:places/features/map/presentation/chosen_place_cubit/chosen_place_cubit.dart';
import 'package:places/features/map/presentation/map_launcher_cubit/map_launcher_cubit.dart';
import 'package:places/features/map/presentation/widgets/map_app_picker.dart';
import 'package:places/features/map/presentation/widgets/map_place_card.dart';

class ChosenPlaceCard extends StatelessWidget {
  const ChosenPlaceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChosenPlaceCubit, ChosenPlaceState>(
      builder: (_, state) {
        final place = state.place;

        return BlocListener<MapLauncherCubit, MapLauncherState>(
          listener: (context, state) => _mapLauncherListener(
            context,
            state,
            place,
          ),
          child: AnimatedPositioned(
            right: 16,
            left: 16,
            bottom: state.isPlaceChosen ? 0 : -100,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInCirc,
            onEnd: () {
              // Скрываем слой выбранной карточки.
              if (!state.isPlaceChosen) {
                context.read<ChosenPlaceCubit>().hidePlaceLayer();
              }
            },
            child: place != null && !state.isPlaceLayerHidden
                ? MapPlaceCard(
                    key: ValueKey(place.id),
                    place,
                    toggleFavorites: () {
                      context.read<FavouritePlacesBloc>().add(
                            FavouritePlacesToFavouritesPressed(place),
                          );
                    },
                    onBuildRoutePressed:
                        context.read<MapLauncherCubit>().openMapAppPicker,
                  )
                : const SizedBox.shrink(),
          ),
        );
      },
    );
  }

  Future<void> _mapLauncherListener(
    BuildContext context,
    MapLauncherState state,
    Place? place,
  ) async {
    if (state is MapLauncherShowInstalledMapsPicker && place != null) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => MapAppPicker(
          place: place,
          maps: state.installedMaps,
          onMapPressed: (action) =>
              context.read<MapLauncherCubit>().showDirections(
                    mapType: action.type,
                    place: place,
                  ),
        ),
      );
    }
  }
}
