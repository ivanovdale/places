import 'package:flutter/material.dart';

/// Название места.
class PlaceName extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  const PlaceName(
    this.text, {
    Key? key,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24.0,
        left: 16.0,
      ),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
