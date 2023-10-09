import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/custom_buttons/custom_elevated_button.dart';

/// Кнопка создания места.
class CreateButton extends StatelessWidget {
  final VoidCallback onButtonPressed;

  const CreateButton({
    super.key,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 24,
          bottom: 16,
        ),
        child: CustomElevatedButton(
          text: AppStrings.create,
          textStyle: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.secondary.withOpacity(0.56),
          ),
          backgroundColor: theme.colorScheme.secondaryContainer,
          height: 48,
          onPressed: onButtonPressed,
        ),
      ),
    );
  }
}
