import 'package:flutter/material.dart';

/// Кнопка скрытия боттомшита.
class SwipeDownButton extends StatelessWidget {
  const SwipeDownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 12,
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
    );
  }
}
