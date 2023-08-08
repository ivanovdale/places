import 'package:flutter/material.dart';

/// Заголовок страницы онбординга.
class OnBoardingPageItemTitle extends StatelessWidget {
  final String data;
  final TextStyle style;

  const OnBoardingPageItemTitle({
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
