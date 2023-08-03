import 'package:flutter/material.dart';
import 'package:places/features/place_filters/presentation/widgets/place_type_filters/components/place_type_filters_grid_view.dart';
import 'package:places/features/place_filters/presentation/widgets/place_type_filters/components/place_type_filters_scrollable_row.dart';
import 'package:places/utils/screen_util.dart';

/// Фильтрации по категории мест.
///
/// Отображает картинки типов мест с их обозначениями.
/// Показывает, установлен ли фильтр по той или иной категории.
class PlaceTypeFilters extends StatelessWidget {
  const PlaceTypeFilters({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO(ivanovdale):  bloc
    final dataStorage = _InheritedFiltersScreenState.of(context);
    final selectedPlaceTypeFilters = dataStorage.selectedPlaceTypeFilters;

    // Для больших экранов отображать фильтры мест в виде сетки.
    // А для экранов малого размера - в виде скролящейся строки.
    return !context.isSmallScreenWidth
        ? PlaceTypeFiltersGridView(
            selectedPlaceTypeFilters: selectedPlaceTypeFilters,
          )
        : PlaceTypeFiltersScrollableRow(
            selectedPlaceTypeFilters: selectedPlaceTypeFilters,
          );
  }
}
