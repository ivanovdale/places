import 'package:flutter/material.dart';

/// Индикатор прокрутки страниц онбординга.
class OnBoardingPageIndicator extends StatelessWidget {
  final int length;
  final PageController controller;
  final int activePage;

  const OnBoardingPageIndicator({
    super.key,
    required this.length,
    required this.controller,
    required this.activePage,
  });

  void _indicatorOnTap(int index) {
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(
          length,
          (index) => InkWell(
            onTap: () => _indicatorOnTap(index),
            child: Container(
              height: 8,
              width: index == activePage ? 24 : 8,
              decoration: BoxDecoration(
                color: index == activePage
                    ? theme.colorScheme.primary
                    : theme.colorScheme.secondary.withOpacity(0.56),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
