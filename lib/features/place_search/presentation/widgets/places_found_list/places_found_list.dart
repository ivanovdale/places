import 'package:flutter/material.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/place_search/presentation/widgets/places_found_list/components/place_found_item.dart';
import 'package:places/features/place_search/presentation/widgets/places_found_list/components/places_not_found_info.dart';

/// Список найденных мест.
class PlacesFoundList extends StatelessWidget {
  final List<Place> placesFoundList;
  final ValueSetter<Place>? onPlacesFoundItemPressed;
  final String searchString;

  const PlacesFoundList({
    super.key,
    required this.placesFoundList,
    this.onPlacesFoundItemPressed,
    required this.searchString,
  });

  @override
  Widget build(BuildContext context) {
    return placesFoundList.isNotEmpty
        ? Expanded(
            child: ListView(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 43,
              ),
              children: placesFoundList.map((placeFoundItem) {
                final isLastItem = placesFoundList.last == placeFoundItem;

                return PlaceFoundItem(
                  place: placeFoundItem,
                  searchString: searchString,
                  onPlaceFoundItemPressed: onPlacesFoundItemPressed,
                  isLastItem: isLastItem,
                );
              }).toList(),
            ),
          )
        // Отобразить информацию, что места не найдены.
        : const PlacesNotFoundInfo();
  }
}
