import 'package:flutter/material.dart';
import 'package:places/features/on_boarding/domain/on_boarding_data.dart';
import 'package:places/features/on_boarding/presentation/widgets/on_boarding_page_view/components/on_boarding_page_item_description.dart';
import 'package:places/features/on_boarding/presentation/widgets/on_boarding_page_view/components/on_boarding_page_item_icon.dart';
import 'package:places/features/on_boarding/presentation/widgets/on_boarding_page_view/components/on_boarding_page_item_title.dart';

/// Страница онбординга.
///
/// Содержит приветственную картинку и краткую информацию о возможностях приложения.
class OnBoardingPageItem extends StatelessWidget {
  final OnBoardingData data;

  const OnBoardingPageItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColorDark = theme.primaryColorDark;
    final pageItemTitleStyle = theme.textTheme.headlineSmall!.copyWith(
      color: primaryColorDark,
    );
    final pageItemDescriptionStyle = theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.secondary,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OnBoardingPageItemIcon(
          assetName: data.icon,
          color: primaryColorDark,
        ),
        OnBoardingPageItemTitle(
          data: data.title,
          style: pageItemTitleStyle,
        ),
        OnBoardingPageItemDescription(
          data: data.description,
          style: pageItemDescriptionStyle,
        ),
      ],
    );
  }
}
