import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/place_card/draggable_place_card.dart';

/// Перетаскиваемая карточка места с возможностью перетаскивать на неё другие карточки для сортировки списка мест.
class DraggablePlaceCardWithDragTargetOption extends StatelessWidget {
  final int index;
  final Widget placeCard;
  final bool isDragged;
  final VoidCallback? onDragStarted;
  final Function(DraggableDetails) onDragEnd;
  final Function(int)? onAccept;
  final Function(PointerMoveEvent)? scrollPlaceCardsWhenCardDragged;

  const DraggablePlaceCardWithDragTargetOption({
    Key? key,
    required this.index,
    this.onAccept,
    required this.placeCard,
    required this.isDragged,
    this.onDragStarted,
    required this.onDragEnd,
    this.scrollPlaceCardsWhenCardDragged,
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
          onPointerMove: isDragged ? scrollPlaceCardsWhenCardDragged : null,
          child: DraggablePlaceCard(
            placeCard: placeCard,
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
