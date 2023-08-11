import 'package:flutter/material.dart';

/// Описание места.
class PlaceDescription extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  const PlaceDescription(
      this.text, {
        super.key,
        required this.textStyle,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 24,
        left: 16,
        right: 16,
      ),
      height: 90,
      child: SingleChildScrollView(
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
