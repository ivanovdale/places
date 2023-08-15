import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/presentation/widgets/custom_circular_loading_indicator.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_place_cubit/favourite_place_cubit.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_bloc.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_event.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_state.dart';
import 'package:places/features/favourite_places/presentation/widgets/visiting_place_list/to_visit_place_list.dart';
import 'package:places/features/favourite_places/presentation/widgets/visiting_place_list/visited_place_list.dart';

class VisitingTabBarView extends StatelessWidget {
  final TabController tabController;

  const VisitingTabBarView({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<FavouritePlacesBloc, FavouritePlacesState>(
        builder: (_, state) => switch (state.status) {
          FavouritePlacesStatus.loading => const Center(
            child: CustomCircularLoadingIndicator(),
          ),
          FavouritePlacesStatus.success => _TabBarView(
              tabController: tabController,
            ),
        },
      ),
    );
  }
}

class _TabBarView extends StatelessWidget {
  final TabController tabController;

  const _TabBarView({
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FavouritePlacesBloc>();

    void onPlaceDeleted(Place place) => bloc.add(
          FavouritePlacesToFavouritesPressed(place),
        );

    void onPlaceInserted(Place place, Place targetPlace) => bloc.add(
          FavouritePlacesPlaceInserted(
            place: place,
            targetPlace: targetPlace,
          ),
        );

    void onPlaceDateTimePicked(
      BuildContext context,
      DateTime pickedDateTime,
    ) =>
        context
            .read<FavouritePlaceCubit>()
            .updateToVisitPlaceDateTime(pickedDateTime);

    return BlocBuilder<FavouritePlacesBloc, FavouritePlacesState>(
      builder: (_, state) {
        return TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
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
