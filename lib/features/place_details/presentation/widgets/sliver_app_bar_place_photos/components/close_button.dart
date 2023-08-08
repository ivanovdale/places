import 'package:flutter/material.dart';

/// Кнопка "Закрыть" боттомшит.
class CloseButton extends StatelessWidget {
  const CloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      top: 6,
      child: IconButton(
        icon: const Icon(
          Icons.cancel,
          size: 40,
        ),
        color: Theme.of(context).colorScheme.onBackground,
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
