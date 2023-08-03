import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_place_cubit/favourite_place_cubit.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_bloc.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_event.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_state.dart';
import 'package:places/features/favourite_places/presentation/widgets/visiting_place_list/to_visit_place_list.dart';
import 'package:places/features/favourite_places/presentation/widgets/visiting_place_list/visited_place_list.dart';

class VisitingTabBarView extends StatelessWidget {
  const VisitingTabBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<FavouritePlacesBloc, FavouritePlacesState>(
        builder: (context, state) {
          return switch (state.status) {
            FavouritePlacesStatus.loading => const Center(
                child: CircularProgressIndicator(),
              ),
            FavouritePlacesStatus.success => const _TabBarView(),
          };
        },
      ),
    );
  }
}

class _TabBarView extends StatelessWidget {
  const _TabBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FavouritePlacesBloc>();

    void onPlaceDeleted(Place place) => bloc.add(
          ToggleFavouritesEvent(place),
        );

    void onPlaceInserted(Place place, Place targetPlace) => bloc.add(
          InsertPlaceEvent(
            place: place,
            targetPlace: targetPlace,
          ),
        );

    void onPlaceDateTimePicked(
      BuildContext context,
      DateTime pickedDateTime,
    ) {
      context
          .read<FavouritePlaceCubit>()
          .updateToVisitPlaceDateTime(pickedDateTime);
    }

    return BlocBuilder<FavouritePlacesBloc, FavouritePlacesState>(
      builder: (context, state) {
        return TabBarView(
          children: [
            ToVisitPlaceList(
              state.notVisitedPlaces,
              onPlaceDeleted: onPlaceDeleted,
              onPlaceInserted: onPlaceInserted,
              onPlaceDateTimePicked: onPlaceDateTimePicked,
            ),
            VisitedPlaceList(
              state.visitedPlaces,
              onPlaceDeleted: onPlaceDeleted,
              onPlaceInserted: onPlaceInserted,
            ),
          ],
        );
      },
    );
  }
}
