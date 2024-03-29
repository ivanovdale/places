import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/custom_buttons/custom_text_button.dart';

/// Кнопка отмены добавления нового места.
class CancelButton extends StatelessWidget {
  final VoidCallback onCancelButtonPressed;

  const CancelButton({
    super.key,
    required this.onCancelButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomTextButton(
      AppStrings.cancel,
      textStyle: theme.textTheme.labelLarge?.copyWith(
        color: theme.colorScheme.secondary,
      ),
      padding: const EdgeInsets.only(
        left: 16,
      ),
      onPressed: onCancelButtonPressed,
    );
  }
}
