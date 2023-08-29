import 'package:flutter/material.dart';
import 'package:places/features/add_place/presentation/widgets/photo_carousel/components/action_item.dart';
import 'package:places/features/add_place/presentation/widgets/photo_carousel/components/photo_picker.dart';

/// Возможные действия для добавления фото.
class AddPhotoActions extends StatelessWidget {
  final List<ActionElement> actions;
  final ValueSetter<ActionElement> onActionPressed;

  const AddPhotoActions({
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
