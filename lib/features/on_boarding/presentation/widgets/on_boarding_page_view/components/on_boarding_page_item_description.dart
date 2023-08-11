import 'package:flutter/material.dart';

/// Описание страницы онбординга.
class OnBoardingPageItemDescription extends StatelessWidget {
  final String data;
  final TextStyle style;

  const OnBoardingPageItemDescription({
    super.key,
    required this.data,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        data,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }
}
