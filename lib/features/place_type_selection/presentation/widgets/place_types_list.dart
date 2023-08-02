import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/features/place_type_selection/presentation/widgets/place_type_item.dart';
import 'package:places/features/place_type_selection/presentation/widgets/save_button.dart';

/// Список категорий места.
class PlaceTypesList extends StatelessWidget {
  const PlaceTypesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const placeTypes = PlaceTypes.values;

    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: placeTypes.map(
                (placeType) {
                  final isLastItem = placeTypes.last == placeType;

                  return PlaceTypeItem(
                    item: placeType,
                    useDivider: !isLastItem,
                  );
                },
              ).toList(),
            ),
          ),
          const SaveButton(),
        ],
      ),
    );
  }
}
