import 'package:flutter/material.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/utils/string_extension.dart';
import 'package:places/features/place_filters/presentation/widgets/place_type_filters/components/filter_circle.dart';

/// Отображает кликабельную иконку фильтра и его наименование.
class PlaceFilterItem extends StatelessWidget {
  final PlaceTypes placeType;

  const PlaceFilterItem({
    super.key,
    required this.placeType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilterCircle(
          placeType: placeType,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 12,
          ),
          child: Text(
            placeType.text.capitalize(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
