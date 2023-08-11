import 'package:flutter/material.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/place_search/presentation/widgets/places_found_list/components/place_found_item_divider.dart';

/// Детали найденного места.
class PlaceFoundDetails extends StatelessWidget {
  final Place place;
  final String searchString;
  final bool isLastItem;

  const PlaceFoundDetails({
    super.key,
    required this.place,
    required this.isLastItem,
    required this.searchString,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final placeNameTextStyle = theme.textTheme.bodyLarge?.copyWith(
      color: theme.primaryColorDark,
    );
    final highlightedPlaceNameTextStyle = placeNameTextStyle!.copyWith(
      fontWeight: FontWeight.bold,
    );
    final placeTypeTextStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.secondary,
    );

    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: highlightOccurrences(
                place.name,
                searchString,
                highlightStyle: highlightedPlaceNameTextStyle,
              ),
              style: placeNameTextStyle,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            place.type.toString(),
            style: placeTypeTextStyle,
          ),
          // Не отрисовывать разделитель для последнего элемента списка.
          if (isLastItem) const SizedBox() else const PlaceFoundItemDivider(),
        ],
      ),
    );
  }

  /// Делает выделение текста [query] в строке [source] заданным стилем [highlightStyle].
  List<TextSpan> highlightOccurrences(
    String source,
    String query, {
    required TextStyle highlightStyle,
  }) {
    if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: source)];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    var lastMatchEnd = 0;

    final children = <TextSpan>[];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: highlightStyle,
      ));

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }

    return children;
  }
}
