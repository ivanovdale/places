import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/place_card/base_place_card.dart';
import 'package:places/UI/screens/components/place_card/place_card_when_dragged.dart';
import 'package:places/UI/screens/components/place_card/place_card_with_hover_ability.dart';

/// Карточка места с возможностью перетаскивания.
class DraggablePlaceCard extends StatelessWidget {
  final VoidCallback? onDragStarted;
  final ValueChanged<DraggableDetails>? onDragEnd;
  final BasePlaceCard placeCard;
  final int index;
  final List<int?> candidateData;

  const DraggablePlaceCard({
    Key? key,
    this.onDragStarted,
    this.onDragEnd,
    required this.placeCard,
    required this.index,
    required this.candidateData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      data: index,
      child: PlaceCardWithHoverAbility(
        placeCard: placeCard,
        candidateData: candidateData,
      ),
      childWhenDragging: const SizedBox(
        height: 50,
      ),
      onDragStarted: onDragStarted,
      onDragEnd: onDragEnd,
      feedback: PlaceCardWhenDragged(placeCard: placeCard),
    );
  }
}
