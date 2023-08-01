import 'package:flutter/material.dart';
import 'package:places/UI/screens/place_details_screen.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/features/place_search/presentation/widgets/places_found_list/components/place_found_details.dart';
import 'package:places/features/place_search/presentation/widgets/places_found_list/components/place_found_image.dart';

/// Найденное место.
class PlaceFoundItem extends StatelessWidget {
  final Place place;
  final String searchString;
  final ValueSetter<Place>? onPlaceFoundItemPressed;
  final bool isLastItem;

  const PlaceFoundItem({
    Key? key,
    required this.place,
    this.isLastItem = false,
    this.onPlaceFoundItemPressed,
    required this.searchString,
  }) : super(key: key);

  /// Сохранение места в истории поиска и открытие боттомшита детализации места.
  void _showPlacesDetailsBottomSheet(BuildContext context, Place place) {
    // Сохранить переход в истории поиска.
    onPlaceFoundItemPressed?.call(place);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PlaceDetailsScreen(place.id ?? 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showPlacesDetailsBottomSheet(context, place),
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
