import 'package:flutter/material.dart';

/// Название места.
class PlaceName extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  const PlaceName(
    this.text, {
    super.key,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
        left: 16,
      ),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
