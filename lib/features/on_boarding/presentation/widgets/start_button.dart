import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/custom_buttons/custom_elevated_button.dart';
import 'package:places/features/on_boarding/res/on_boarding_items.dart';

/// Кнопка перехода на главный экран.
class StartButton extends StatelessWidget {
  final int activePage;
  final VoidCallback onPressed;

  const StartButton({
    super.key,
    required this.activePage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isLastPage = activePage == items.length - 1;

    return isLastPage
        ? Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: CustomElevatedButton(
              text: AppStrings.start,
              backgroundColor: colorScheme.primary,
              height: 48,
              textStyle: theme.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w700,
                color: colorScheme.onBackground,
              ),
              onPressed: onPressed,
            ),
          )
        : const SizedBox(
            height: 64,
          );
  }
}
