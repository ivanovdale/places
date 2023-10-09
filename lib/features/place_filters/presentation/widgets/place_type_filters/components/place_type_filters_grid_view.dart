import 'package:flutter/material.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/place_filters/presentation/widgets/place_type_filters/components/place_filter_item.dart';

/// Отображает фильтры места в виде сетки.
class PlaceTypeFiltersGridView extends StatelessWidget {
  final Set<PlaceTypes> selectedPlaceTypeFilters;

  const PlaceTypeFiltersGridView({
    super.key,
    required this.selectedPlaceTypeFilters,
  });

  @override
  Widget build(BuildContext context) {
    final listOfFilters = PlaceTypes.values.toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 40,
          crossAxisSpacing: 25,
          mainAxisExtent: 90,
        ),
        itemCount: listOfFilters.length,
        itemBuilder: (_, index) {
          final placeFilter = listOfFilters.elementAt(index);

          return PlaceFilterItem(placeType: placeFilter);
        },
      ),
    );
  }
}
