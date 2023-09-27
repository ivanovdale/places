import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/custom_buttons/custom_elevated_button.dart';
import 'package:places/core/presentation/widgets/custom_pickers/custom_action_picker/components/picker_actions.dart';

class CustomActionPicker<T> extends StatelessWidget {
  final List<ActionElement<T>> actions;
  final ValueSetter<ActionElement<T>> onActionPressed;
  final bool closeOnPressed;

  const CustomActionPicker({
    super.key,
    required this.actions,
    required this.onActionPressed,
    required this.closeOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onBackgroundColor = theme.colorScheme.onBackground;

    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      alignment: Alignment.bottomCenter,
      insetPadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            PickerActions<T>(
              actions: actions,
              onActionPressed: (action) {
                onActionPressed(action);
                if (closeOnPressed) Navigator.pop(context);
              },
            ),
            const SizedBox(
              height: 8,
            ),
            CustomElevatedButton(
              text: AppStrings.cancel,
              backgroundColor: onBackgroundColor,
              height: 48,
              textStyle: theme.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.primary,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
