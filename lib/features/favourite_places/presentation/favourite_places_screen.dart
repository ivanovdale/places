import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/UI/screens/components/custom_app_bar.dart';
import 'package:places/UI/screens/components/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_bloc.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_event.dart';
import 'package:places/features/favourite_places/presentation/bloc/favourite_places_bloc/favourite_places_state.dart';
import 'package:places/features/favourite_places/presentation/widgets/visiting_place_list/to_visit_place_list.dart';
import 'package:places/features/favourite_places/presentation/widgets/visiting_place_list/visited_place_list.dart';
import 'package:places/features/favourite_places/presentation/widgets/visiting_tab_bar.dart';
import 'package:places/helpers/app_strings.dart';

/// Экран списка посещенных/планируемых к посещению мест.
///
/// Имеет TabBar для переключения между списками.
class FavouritePlacesScreen extends StatelessWidget {
  const FavouritePlacesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.visitingScreenAppBarTitle,
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        centerTitle: true,
        toolbarHeight: 56.0,
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              VisitingTabBar(),
              _VisitingTabBarView(),
            ],
          ),
        ),
      ),
    );
  }
}

class _VisitingTabBarView extends StatelessWidget {
  const _VisitingTabBarView({Key? key}) : super(key: key);

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
    final bloc = context.watch<FavouritePlacesBloc>();
    final state = bloc.state;

    void onPlaceDeleted(Place place) => bloc.add(
          RemoveFromFavouritesEvent(place),
        );

    void onPlaceInserted(Place place, Place targetPlace) => bloc.add(
          InsertPlaceEvent(
            place: place,
            targetPlace: targetPlace,
          ),
        );

    return TabBarView(children: [
      ToVisitPlaceList(
        state.notVisitedPlaces,
        onPlaceDeleted: onPlaceDeleted,
        onPlaceInserted: onPlaceInserted,
      ),
      VisitedPlaceList(
        state.visitedPlaces,
        onPlaceDeleted: onPlaceDeleted,
        onPlaceInserted: onPlaceInserted,
      ),
    ]);
  }
}
