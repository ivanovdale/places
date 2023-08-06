import 'package:flutter/material.dart';

/// Описание места.
class PlaceDescription extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  const PlaceDescription(
      this.text, {
        Key? key,
        required this.textStyle,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 24.0,
        left: 16.0,
        right: 16.0,
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