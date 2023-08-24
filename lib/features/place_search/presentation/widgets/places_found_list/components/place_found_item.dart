import 'package:flutter/material.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/place_search/presentation/widgets/places_found_list/components/place_found_details.dart';
import 'package:places/features/place_search/presentation/widgets/places_found_list/components/place_found_image.dart';

/// Найденное место.
class PlaceFoundItem extends StatelessWidget {
  final Place place;
  final String searchString;
  final ValueSetter<Place>? onPlaceFoundItemPressed;
  final bool isLastItem;

  const PlaceFoundItem({
    super.key,
    required this.place,
    this.isLastItem = false,
    this.onPlaceFoundItemPressed,
    required this.searchString,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPlaceFoundItemPressed?.call(place),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PlaceFoundImage(
              place: place,
            ),
          ),
          Expanded(
            flex: 5,
            child: PlaceFoundDetails(
              searchString: searchString,
              place: place,
              isLastItem: isLastItem,
            ),
          ),
        ],
      ),
    );
  }
}
