import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/custom_elevated_button.dart';
import 'package:places/helpers/app_strings.dart';

/// Кнопка создания места.
class CreateButton extends StatelessWidget {
  final VoidCallback onButtonPressed;

  const CreateButton({
    Key? key,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 24.0,
          bottom: 16.0,
        ),
        child: CustomElevatedButton(
          AppStrings.create,
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
