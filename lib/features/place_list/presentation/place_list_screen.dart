import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/data/interactor/place_interactor.dart';
import 'package:places/core/helpers/app_router.dart';
import 'package:places/core/presentation/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:places/features/place_filters/domain/place_filters_interactor.dart';
import 'package:places/features/place_list/presentation/bloc/place_list_bloc.dart';
import 'package:places/features/place_list/presentation/widgets/add_new_place_button.dart';
import 'package:places/features/place_list/presentation/widgets/sliver_app_bar/sliver_app_bar.dart'
    as place_list;
import 'package:places/features/place_list/presentation/widgets/sliver_place_list.dart';

/// Экран списка мест.
class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({super.key});

  /// Открывает экран добавления места.
  ///
  /// Если было создано новое место, обновляет экран.
  Future<void> _openAddPlaceScreen(BuildContext context) async {
    var isPlaceCreated = await Navigator.pushNamed<bool>(
      context,
      AppRouter.addPlace,
    );
    isPlaceCreated ??= false;

    if (isPlaceCreated && context.mounted) {
      context.read<PlaceListBloc>().add(
            PlaceListLoaded(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return BlocProvider(
      create: (_) => PlaceListBloc(
        placeInteractor: context.read<PlaceInteractor>(),
        placeFiltersInteractor: context.read<PlaceFiltersInteractor>(),
      )
        ..add(
          PlaceListStarted(),
        ),
      child: Scaffold(
        // Скрываем боттом бар при горизонтальной ориентации.
        bottomNavigationBar: orientation == Orientation.landscape
            ? null
            : const CustomBottomNavigationBar(),
        body: const _PlaceListBody(),
        floatingActionButton: Builder(
          builder: (innerContext) {
            return AddNewPlaceButton(
              onPressed: () => _openAddPlaceScreen(innerContext),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

/// Отображает список мест.
class _PlaceListBody extends StatelessWidget {
  const _PlaceListBody();

  Future<void> _onRefresh(BuildContext context) {
    final bloc = context.read<PlaceListBloc>()
      ..add(
        PlaceListLoaded(),
      );

    return bloc.stream.first;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      edgeOffset: 220,
      onRefresh: () => _onRefresh(context),
      child: const CustomScrollView(
        slivers: [
          place_list.SliverAppBar(),
          SliverPlaceList(),
        ],
      ),
    );
  }
}
