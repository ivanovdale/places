import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/custom_buttons/custom_text_button.dart';
import 'package:places/features/on_boarding/res/on_boarding_items.dart';

/// Кнопка для пропуска онбординга.
class SkipButton extends StatelessWidget {
  final int activePage;
  final VoidCallback onPressed;

  const SkipButton({
    super.key,
    required this.onPressed,
    required this.activePage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLastPage = activePage == items.length - 1;

    return Expanded(
      child: isLastPage
          ? const SizedBox.shrink()
          : Container(
              padding: const EdgeInsets.only(
                right: 16,
              ),
              alignment: Alignment.centerRight,
              child: CustomTextButton(
                AppStrings.skip,
                textStyle: theme.textTheme.labelLarge!.copyWith(
                  color: theme.colorScheme.primary,
                ),
                onPressed: onPressed,
              ),
            ),
    );
  }
}
