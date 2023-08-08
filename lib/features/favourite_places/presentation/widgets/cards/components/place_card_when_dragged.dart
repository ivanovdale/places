import 'package:flutter/material.dart';

/// Карточка места в момент перетаскивания.
class PlaceCardWhenDragged extends StatelessWidget {
  final Widget placeCard;

  const PlaceCardWhenDragged({
    super.key,
    required this.placeCard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
            spreadRadius: 5,
            blurRadius: 7,
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      height: 254,
      child: placeCard,
    );
  }
}
