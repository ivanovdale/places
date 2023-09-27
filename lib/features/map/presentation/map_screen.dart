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
import 'package:places/features/map/data/api/map_launcher_api.dart';
import 'package:places/features/map/data/repository/map_launcher_data_repository.dart';
import 'package:places/features/map/domain/interactor/map_launcher_interactor.dart';
import 'package:places/features/map/presentation/chosen_place_cubit/chosen_place_cubit.dart';
import 'package:places/features/map/presentation/map_launcher_cubit/map_launcher_cubit.dart';
import 'package:places/features/map/presentation/widgets/buttons/geolocation_button/cubit/map_geolocation_cubit.dart';
import 'package:places/features/map/presentation/widgets/buttons/geolocation_button/geolocation_button.dart';
import 'package:places/features/map/presentation/widgets/buttons/refresh_button.dart';
import 'package:places/features/map/presentation/widgets/chosen_place_card.dart';
import 'package:places/features/map/presentation/widgets/places_map.dart';
import 'package:places/features/place_list/presentation/bloc/place_list_bloc.dart';
import 'package:places/features/place_list/presentation/widgets/add_new_place_button.dart';
import 'package:places/features/place_list/presentation/widgets/sliver_app_bar/components/filter_button.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  YandexMapController? _controller;
  bool _arePlacesRefreshing = false;

  /// Открывает экран поиска мест.
  Future<void> _navigateToPlaceSearchScreen(BuildContext context) =>
      Navigator.pushNamed<void>(
        context,
        AppRouter.placeSearch,
      );

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

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
      body: _MapBlocProviders(
        child: _MapListeners(
          controller: _controller,
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
                    alignment: Alignment.center,
                    children: [
                      PlacesMap(
                        places: state.places,
                        userLocation: userLocation.data,
                        onMapCreated: (controller) => setState(
                          () => _controller = controller,
                        ),
                      ),
                      ..._buildButtons(context),
                      const ChosenPlaceCard(),
                    ],
                  ),
                ),
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _buildButtons(BuildContext context) {
    final isPlaceChosen = context.watch<ChosenPlaceCubit>().state.isPlaceChosen;
    final buttonsBottomPositionValue = isPlaceChosen ? 270.0 : 16.0;

    return [
      AnimatedPositioned(
        left: 16,
        bottom: buttonsBottomPositionValue,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInCirc,
        child: RefreshButton(
          showLoadingIndicator: _arePlacesRefreshing,
          onPressed: _onRefreshButtonPressed,
        ),
      ),
      if (!isPlaceChosen)
        Positioned(
          bottom: 16,
          child: AddNewPlaceButton(
            onPressed: () => _openAddPlaceScreen(context),
          ),
        ),
      AnimatedPositioned(
        right: 16,
        bottom: buttonsBottomPositionValue,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInCirc,
        child: GeolocationButton(
          onPressed: context.read<MapGeolocationCubit>().showUserOnMap,
        ),
      ),
    ];
  }

  Future<void> _onRefreshButtonPressed() async {
    final bloc = context.read<PlaceListBloc>()
      ..add(
        PlaceListLoaded(),
      );
    setState(() => _arePlacesRefreshing = true);
    await bloc.stream.first;
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _arePlacesRefreshing = false);
  }

  Future<void> _openAddPlaceScreen(BuildContext context) async {
    var isPlaceCreated = await Navigator.pushNamed<bool>(
      context,
      AppRouter.addPlace,
    );
    isPlaceCreated ??= false;

    if (isPlaceCreated && context.mounted) {
      context.read<PlaceListBloc>().add(PlaceListLoaded());
    }
  }
}

class _MapBlocProviders extends StatelessWidget {
  final Widget child;

  const _MapBlocProviders({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ChosenPlaceCubit(),
        ),
        BlocProvider(
          create: (_) => MapGeolocationCubit(
            geolocationInteractor: context.read<GeolocationInteractor>(),
          ),
        ),
        BlocProvider(
          create: (_) => MapLauncherCubit(
            mapLauncherInteractor: MapLauncherInteractor(
              mapLauncherRepository: MapLauncherDataRepository(
                mapLauncherApi: MapLauncherApiImpl(),
              ),
            ),
            geolocationInteractor: context.read<GeolocationInteractor>(),
          ),
        ),
      ],
      child: child,
    );
  }
}

class _MapListeners extends StatelessWidget {
  final Widget child;
  final YandexMapController? controller;

  const _MapListeners({
    required this.child,
    this.controller,
  });

  void _mapGeolocationCubitListener(
      BuildContext context, MapGeolocationState state) {
    if (state is MapGeolocationStartMovingCamera) {
      final coordinatePoint = state.coordinatePoint;
      controller?.moveCamera(
        animation: const MapAnimation(duration: 0.5),
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: Point(
              latitude: coordinatePoint.lat,
              longitude: coordinatePoint.lon,
            ),
            zoom: 12,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapGeolocationCubit, MapGeolocationState>(
      listener: _mapGeolocationCubitListener,
      child: child,
    );
  }
}
