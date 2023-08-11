import 'package:flutter/material.dart';

/// Кнопка для выбора категории места.
class PlaceTypeSelectionButton extends StatelessWidget {
  const PlaceTypeSelectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Theme.of(context).primaryColorDark,
        size: 15,
      ),
    );
  }
}
