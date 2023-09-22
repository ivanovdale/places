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
import 'package:places/features/map/utils/placemark_map_object_helper.dart';
import 'package:places/features/place_list/presentation/bloc/place_list_bloc.dart';
import 'package:places/features/place_list/presentation/widgets/sliver_app_bar/components/filter_button.dart';
import 'package:places/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

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
      body: BlocSelector<PlaceListBloc, PlaceListState, PlaceListStatusPlaces>(
        selector: (state) => (status: state.status, places: state.places),
        builder: (_, statusPlaces) => switch (statusPlaces.status) {
          PlaceListStatus.failure => const ErrorPlaceHolder(),
          PlaceListStatus.initial ||
          PlaceListStatus.loading ||
          PlaceListStatus.success =>
            StreamBuilder<CoordinatePoint>(
              stream: context.read<GeolocationInteractor>().userCurrentLocation,
              builder: (_, userLocation) => YandexMap(
                nightModeEnabled:
                    context.watch<SettingsCubit>().state.isDarkModeEnabled,

                mapObjects: PlacemarkMapObjectHelper.getMapObjects(
                  places: statusPlaces.places,
                  userLocation: userLocation.data,
                  addUserPlacemark: true,
                ),
              ),
            ),
        },
      ),
    );
  }
}
