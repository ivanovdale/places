import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/sight_card/draggable_sight_card.dart';

/// Перетаскиваемая карточка места с возможностью перетаскивать на неё другие карточки для сортировки списка мест.
class DraggableSightCardWithDragTargetOption extends StatelessWidget {
  final int index;
  final Widget sightCard;
  final bool isDragged;
  final VoidCallback? onDragStarted;
  final Function(DraggableDetails) onDragEnd;
  final Function(int)? onAccept;
  final Function(PointerMoveEvent)? scrollSightCardsWhenCardDragged;

  const DraggableSightCardWithDragTargetOption({
    Key? key,
    required this.index,
    this.onAccept,
    required this.sightCard,
    required this.isDragged,
    this.onDragStarted,
    required this.onDragEnd,
    this.scrollSightCardsWhenCardDragged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      onWillAccept: (data) {
        return true;
      },
      onAccept: onAccept,
      builder: (
        context,
        candidateData,
        rejectedData,
      ) {
        return Listener(
          // Возможность скроллинга в момент перетаскивания карточки.
          onPointerMove: isDragged ? scrollSightCardsWhenCardDragged : null,
          child: DraggableSightCard(
            sightCard: sightCard,
            index: index,
            candidateData: candidateData,
            onDragStarted: onDragStarted,
            onDragEnd: onDragEnd,
          ),
        );
      },
    );
  }
}
