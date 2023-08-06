import 'package:flutter/material.dart';
import 'package:places/features/on_boarding/presentation/widgets/on_boarding_page_view/components/on_boarding_page_item.dart';
import 'package:places/features/on_boarding/res/on_boarding_items.dart';

/// Прокручивающийся список страниц.
class OnBoardingPageView extends StatelessWidget {
  final PageController controller;
  final ValueChanged<int>? onPageChanged;

  const OnBoardingPageView({
    Key? key,
    required this.controller,
    this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: MediaQuery.of(context).orientation == Orientation.portrait ? 5 : 10,
      child: PageView.builder(
        controller: controller,
        onPageChanged: onPageChanged,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return OnBoardingPageItem(
            data: items[index],
          );
        },
      ),
    );
  }
}
