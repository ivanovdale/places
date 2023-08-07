import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/core/data/interactor/place_interactor.dart';
import 'package:places/core/helpers/app_router.dart';
import 'package:places/core/presentation/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:places/features/place_list/presentation/widgets/add_new_place_button.dart';
import 'package:places/features/place_list/presentation/widgets/sliver_app_bar/sliver_app_bar.dart'
    as place_list;
import 'package:places/features/place_list/presentation/widgets/sliver_place_list.dart';
import 'package:places/stores/place_list_store/place_list_store_base.dart';
import 'package:provider/provider.dart';

/// Экран списка мест.
class PlaceListScreen extends StatefulWidget {
  const PlaceListScreen({Key? key}) : super(key: key);

  @override
  State<PlaceListScreen> createState() => _PlaceListScreenState();
}

/// Состояние экрана списка мест.
///
/// Обновляет список при добавлении нового места.
class _PlaceListScreenState extends State<PlaceListScreen> {
  late PlaceListStore _store;

  @override
  void initState() {
    super.initState();

    _store = PlaceListStore(
      context.read<PlaceInteractor>(),
    );
    _store.getFilteredPlaces();
  }

  /// Открывает экран добавления места.
  ///
  /// Если было создано новое место, обновляет экран.
  Future<void> _openAddPlaceScreen(BuildContext context) async {
    var isPlaceCreated = await Navigator.pushNamed<bool>(
      context,
      AppRouter.addPlace,
    );
    isPlaceCreated ??= false;

    if (isPlaceCreated && mounted) {
      await context.read<PlaceListStore>().getFilteredPlaces();
    }
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Provider<PlaceListStore>(
      create: (context) => _store,
      child: Scaffold(
        // Скрываем боттом бар при горизонтальной ориентации.
        bottomNavigationBar: orientation == Orientation.landscape
            ? null
            : const CustomBottomNavigationBar(),
        body: const _PlaceListBody(),
        floatingActionButton: AddNewPlaceButton(
          onPressed: () => _openAddPlaceScreen(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

/// Отображает список мест.
class _PlaceListBody extends StatelessWidget {
  const _PlaceListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        place_list.SliverAppBar(),
        SliverPlaceList(),
      ],
    );
  }
}
