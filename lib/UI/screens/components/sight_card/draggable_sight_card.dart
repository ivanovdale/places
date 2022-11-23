import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/sight_card/sight_card_when_dragged.dart';
import 'package:places/UI/screens/components/sight_card/sight_card_with_hover_ability.dart';

/// Карточка места с возможностью перетаскивания.
class DraggableSightCard extends StatelessWidget {
  final VoidCallback? onDragStarted;
  final Function(DraggableDetails)? onDragEnd;
  final Widget sightCard;
  final int index;
  final List<int?> candidateData;

  const DraggableSightCard({
    Key? key,
    this.onDragStarted,
    this.onDragEnd,
    required this.sightCard,
    required this.index,
    required this.candidateData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      data: index,
      child: SightCardWithHoverAbility(
        sightCard: sightCard,
        candidateData: candidateData,
      ),
      childWhenDragging: const SizedBox(
        height: 50,
      ),
      onDragStarted: onDragStarted,
      onDragEnd: onDragEnd,
      feedback: SightCardWhenDragged(sightCard: sightCard),
    );
  }
}
