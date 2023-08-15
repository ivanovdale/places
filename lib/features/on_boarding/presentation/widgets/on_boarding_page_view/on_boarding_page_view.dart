import 'package:flutter/material.dart';
import 'package:places/features/on_boarding/presentation/widgets/on_boarding_page_view/components/on_boarding_page_item.dart';
import 'package:places/features/on_boarding/res/on_boarding_items.dart';

/// Прокручивающийся список страниц.
class OnBoardingPageView extends StatelessWidget {
  final PageController pageController;
  final ValueChanged<int>? onPageChanged;

  const OnBoardingPageView({
    super.key,
    required this.pageController,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: MediaQuery.of(context).orientation == Orientation.portrait ? 5 : 10,
      child: PageView.builder(
        controller: pageController,
        onPageChanged: onPageChanged,
        itemCount: items.length,
        itemBuilder: (_, index) => OnBoardingPageItem(
          data: items[index],
          pageController: pageController,
        ),
      ),
    );
  }
}
