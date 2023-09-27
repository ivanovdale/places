import 'package:flutter/material.dart';
import 'package:places/core/presentation/widgets/custom_pickers/custom_action_picker/components/action_item.dart';

typedef ActionElement<T> = ({String? icon, String text, T type});

/// Возможные действия.
class PickerActions<T> extends StatelessWidget {
  final List<ActionElement<T>> actions;
  final ValueSetter<ActionElement<T>> onActionPressed;

  const PickerActions({
    super.key,
    required this.actions,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onBackgroundColor = theme.colorScheme.onBackground;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: onBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: actions
            .map(
              (action) => ActionItem(
                action: action,
                onActionPressed: onActionPressed,
                isLastItem: action == actions.last,
              ),
            )
            .toList(),
      ),
    );
  }
}
