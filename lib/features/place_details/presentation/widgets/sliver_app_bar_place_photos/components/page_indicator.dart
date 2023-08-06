import 'package:flutter/material.dart';

/// Индикатор прокрутки галлереи.
class PageIndicator extends StatelessWidget {
  final int length;
  final PageController controller;
  final int activePage;

  const PageIndicator({
    Key? key,
    required this.length,
    required this.controller,
    required this.activePage,
  }) : super(key: key);

  /// Устанавливает текущую фотографию галлереи.
  void _indicatorOnTap(int index) {
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return length > 1
        ? Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 12,
            child: Row(
              children: List<Widget>.generate(
                length,
                (index) => InkWell(
                  onTap: () => _indicatorOnTap(index),
                  child: Container(
                    width: MediaQuery.of(context).size.width / length,
                    decoration: BoxDecoration(
                      color: activePage == index
                          ? Theme.of(context).primaryColorDark
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          )
        // Не отображать индикатор фотографий, если количество фото меньше 2.
        : const SizedBox.shrink();
  }
}
