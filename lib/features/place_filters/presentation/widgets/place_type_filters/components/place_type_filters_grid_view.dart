import 'package:flutter/material.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/place_filters/presentation/widgets/place_type_filters/components/place_filter_item.dart';

/// Отображает фильтры места в виде сетки.
class PlaceTypeFiltersGridView extends StatelessWidget {
  final Set<PlaceTypes> selectedPlaceTypeFilters;

  const PlaceTypeFiltersGridView({
    Key? key,
    required this.selectedPlaceTypeFilters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listOfFilters = PlaceTypes.values.toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 40,
          crossAxisSpacing: 25,
        ),
        itemCount: listOfFilters.length,
        itemBuilder: (context, index) {
          final placeFilter = listOfFilters.elementAt(index);

          return PlaceFilterItem(placeType: placeFilter);
        },
      ),
    );
  }
}
