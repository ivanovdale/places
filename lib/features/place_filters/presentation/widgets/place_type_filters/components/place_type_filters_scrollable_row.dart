import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/features/place_filters/presentation/widgets/place_type_filters/components/place_filter_item.dart';

/// Отображает фильтры места в виде скролящейся строки.
class PlaceTypeFiltersScrollableRow extends StatelessWidget {
  final Set<PlaceTypes> selectedPlaceTypeFilters;

  const PlaceTypeFiltersScrollableRow({
    Key? key,
    required this.selectedPlaceTypeFilters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: PlaceTypes.values
            .map(
              (placeType) => Padding(
                padding: const EdgeInsets.only(right: 44.0),
                child: PlaceFilterItem(
                  placeType: placeType,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
