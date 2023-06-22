import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/place_card/base_place_card.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/features/favourite_places/presentation/widgets/cards/components/draggable_place_card.dart';


/// Перетаскиваемая карточка места с возможностью перетаскивать на неё другие карточки для сортировки списка мест.
class DraggablePlaceCardWithDragTargetOption extends StatelessWidget {
  final int index;
  final Place place;
  final BasePlaceCard placeCard;
  final bool isDragged;
  final VoidCallback? onDragStarted;
  final ValueChanged<DraggableDetails> onDragEnd;
  final ValueChanged<Place>? onAccept;
  final ValueChanged<PointerMoveEvent>? scrollPlaceCardsWhenCardDragged;

  const DraggablePlaceCardWithDragTargetOption({
    Key? key,
    required this.index,
    required this.place,
    this.onAccept,
    required this.placeCard,
    required this.isDragged,
    this.onDragStarted,
    required this.onDragEnd,
    this.scrollPlaceCardsWhenCardDragged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<Place>(
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
            place: place,
            candidateData: candidateData,
            onDragStarted: onDragStarted,
            onDragEnd: onDragEnd,
          ),
        );
      },
    );
  }
}
