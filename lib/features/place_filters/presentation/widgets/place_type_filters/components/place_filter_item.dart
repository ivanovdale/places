import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/features/place_filters/presentation/widgets/place_type_filters/components/filter_circle.dart';
import 'package:places/utils/string_extension.dart';

/// Отображает кликабельную иконку фильтра и его наименование.
class PlaceFilterItem extends StatelessWidget {
  final PlaceTypes placeType;

  const PlaceFilterItem({
    Key? key,
    required this.placeType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilterCircle(
          placeFilter: placeType,
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
