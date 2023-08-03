import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/custom_text_button.dart';
import 'package:places/core/helpers/app_strings.dart';

/// Кнопка отмены добавления нового места.
class CancelButton extends StatelessWidget {
  final VoidCallback onCancelButtonPressed;

  const CancelButton({
    Key? key,
    required this.onCancelButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomTextButton(
      AppStrings.cancel,
      textStyle: theme.textTheme.labelLarge?.copyWith(
        color: theme.colorScheme.secondary,
      ),
      padding: const EdgeInsets.only(
        left: 16.0,
      ),
      onPressed: onCancelButtonPressed,
    );
  }
}
