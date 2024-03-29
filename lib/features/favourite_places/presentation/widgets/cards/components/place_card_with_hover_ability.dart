import 'package:flutter/material.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/presentation/widgets/place_card/base_place_card.dart';

/// Карточка места с подсветкой в момент, когда над ней происходит перетаскивание другой карточки.
/// Идентифицирует о возможности сделать дроп в эту область.
class PlaceCardWithHoverAbility extends StatelessWidget {
  final BasePlaceCard placeCard;
  final List<Place?> candidateData;

  const PlaceCardWithHoverAbility({
    super.key,
    required this.placeCard,
    required this.candidateData,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          if (candidateData.isNotEmpty)
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
              blurRadius: 2,
              spreadRadius: 0.5,
              offset: const Offset(0, -7),
              blurStyle: BlurStyle.inner,
            )
          else
            const BoxShadow(color: Colors.transparent),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: placeCard,
    );
  }
}
