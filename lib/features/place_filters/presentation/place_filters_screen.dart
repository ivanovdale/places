import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/interactor/place_interactor.dart';
import 'package:places/core/presentation/widgets/custom_app_bar.dart';
import 'package:places/features/place_filters/domain/place_filters_interactor.dart';
import 'package:places/features/place_filters/presentation/bloc/place_filters_bloc.dart';
import 'package:places/features/place_filters/presentation/widgets/back_button.dart'
    as filters;
import 'package:places/features/place_filters/presentation/widgets/clear_button.dart';
import 'package:places/features/place_filters/presentation/widgets/distance_filter_slider.dart';
import 'package:places/features/place_filters/presentation/widgets/distance_filter_title.dart';
import 'package:places/features/place_filters/presentation/widgets/place_type_filters/place_type_filters.dart';
import 'package:places/features/place_filters/presentation/widgets/place_types_title.dart';
import 'package:places/features/place_filters/presentation/widgets/show_places_elevated_button.dart';
import 'package:places/mocks.dart' as mocked;

/// Экран выбора фильтров места.
///
/// Отображает возможные фильтры мест - категория места и расстояние до места.
/// Показывает количество мест после фильтрации.
/// Позволяет очистить все фильтры сразу.
class PlaceFiltersScreen extends StatelessWidget {
  const PlaceFiltersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final placeInteractor = context.read<PlaceInteractor>();

    return BlocProvider(
      create: (_) => PlaceFiltersBloc(
        placeInteractor: placeInteractor,
        placeFiltersInteractor: context.read<PlaceFiltersInteractor>(),
        userCoordinates: mocked.userCoordinates,
      )..add(
          PlaceFiltersStarted(),
        ),
      child: const Scaffold(
        appBar: CustomAppBar(
          toolbarHeight: 56,
          leading: filters.BackButton(),
          actions: [
            ClearButton(),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              PlaceTypesTitle(),
              PlaceTypeFilters(),
              DistanceFilterTitle(),
              DistanceFilterSlider(),
              Spacer(),
              ShowPlacesElevatedButton(),
            ],
          ),
        ),
      ),
    );
  }
}
