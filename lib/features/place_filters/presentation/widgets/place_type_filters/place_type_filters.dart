import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/utils/screen_util.dart';
import 'package:places/features/place_filters/presentation/bloc/place_filters_bloc.dart';
import 'package:places/features/place_filters/presentation/widgets/place_type_filters/components/place_type_filters_grid_view.dart';
import 'package:places/features/place_filters/presentation/widgets/place_type_filters/components/place_type_filters_scrollable_row.dart';

/// Фильтрации по категории мест.
///
/// Отображает картинки типов мест с их обозначениями.
/// Показывает, установлен ли фильтр по той или иной категории.
class PlaceTypeFilters extends StatelessWidget {
  const PlaceTypeFilters({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectedPlaceTypeFilters =
        context.select<PlaceFiltersBloc, Set<PlaceTypes>>(
      (bloc) => bloc.state.selectedPlaceTypeFilters,
    );

    // Для больших экранов отображать фильтры мест в виде сетки.
    // А для экранов малого размера - в виде скролящейся строки.
    return !context.isSmallScreen
        ? PlaceTypeFiltersGridView(
            selectedPlaceTypeFilters: selectedPlaceTypeFilters,
          )
        : PlaceTypeFiltersScrollableRow(
            selectedPlaceTypeFilters: selectedPlaceTypeFilters,
          );
  }
}
