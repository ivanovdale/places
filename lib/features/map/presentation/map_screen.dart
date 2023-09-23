import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/interactor/geolocation_interactor.dart';
import 'package:places/core/domain/model/coordinate_point.dart';
import 'package:places/core/helpers/app_router.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/custom_app_bar.dart';
import 'package:places/core/presentation/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:places/core/presentation/widgets/placeholders/error_placeholder.dart';
import 'package:places/core/presentation/widgets/search_bar.dart'
    as custom_search_bar;
import 'package:places/features/map/presentation/chosen_place_cubit/chosen_place_cubit.dart';
import 'package:places/features/map/presentation/widgets/chosen_place_card.dart';
import 'package:places/features/map/presentation/widgets/places_map.dart';
import 'package:places/features/place_list/presentation/bloc/place_list_bloc.dart';
import 'package:places/features/place_list/presentation/widgets/sliver_app_bar/components/filter_button.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  /// Открывает экран поиска мест.
  Future<void> _navigateToPlaceSearchScreen(BuildContext context) =>
      Navigator.pushNamed<void>(
        context,
        AppRouter.placeSearch,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.mapScreenAppBarTitle,
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        centerTitle: true,
        toolbarHeight: 116,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: custom_search_bar.SearchBar(
              readOnly: true,
              onTap: () => _navigateToPlaceSearchScreen(context),
              suffixIcon: const FilterButton(),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: BlocProvider(
        create: (_) => ChosenPlaceCubit(),
        child: BlocBuilder<PlaceListBloc, PlaceListState>(
          builder: (context, state) => switch (state.status) {
            PlaceListStatus.failure => const ErrorPlaceHolder(),
            PlaceListStatus.initial ||
            PlaceListStatus.loading ||
            PlaceListStatus.success =>
              StreamBuilder<CoordinatePoint>(
                stream:
                    context.read<GeolocationInteractor>().userCurrentLocation,
                builder: (_, userLocation) => Stack(
                  children: [
                    PlacesMap(
                      places: state.places,
                      userLocation: userLocation.data,
                    ),
                    const ChosenPlaceCard(),
                  ],
                ),
              ),
          },
        ),
      ),
    );
  }
}
