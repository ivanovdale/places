import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/sight_card/sight_card_bottom.dart';
import 'package:places/ui/screen/sight_card/sight_card_top.dart';

/// Виджет карточки достопримечательности.
///
/// Отображает краткую информацию о месте.
///
/// Обязательный параметр конструктора: [sight] - модель достопримечательности.
class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Column(
          children: [
            Expanded(
              child: SightCardTop(sight: sight),
            ),
            Expanded(
              child: SightCardBottom(sight: sight),
            ),
          ],
        ),
      ),
    );
  }
}
