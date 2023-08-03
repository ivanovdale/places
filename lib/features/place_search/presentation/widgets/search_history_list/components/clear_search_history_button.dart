import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/custom_text_button.dart';
import 'package:places/core/helpers/app_strings.dart';

/// Кнопка очищения истории поиска.
class ClearSearchHistoryButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ClearSearchHistoryButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.centerLeft,
      child: CustomTextButton(
        AppStrings.clearHistory,
        textStyle: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.primary,
        ),
        padding: const EdgeInsets.only(
          top: 28,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
