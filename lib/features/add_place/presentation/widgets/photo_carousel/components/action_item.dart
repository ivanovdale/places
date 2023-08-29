import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/features/add_place/presentation/widgets/photo_carousel/components/add_photo_action_padded_divider.dart';
import 'package:places/features/add_place/presentation/widgets/photo_carousel/components/photo_picker.dart';

/// Действие добавления новой фотографии.
class ActionItem extends StatelessWidget {
  final ActionElement action;
  final ValueSetter<ActionElement> onActionPressed;
  final bool isLastItem;

  const ActionItem({
    super.key,
    required this.action,
    required this.onActionPressed,
    required this.isLastItem,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => onActionPressed(action),
          child: Row(
            children: [
              SvgPicture.asset(
                action.icon,
                height: 24,
                colorFilter: ColorFilter.mode(
                  secondaryColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                action.text,
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: secondaryColor,
                ),
              ),
            ],
          ),
        ),
        // Для последнего элемента не добавляем разделитель.
        if (!isLastItem) const AddPhotoActionPaddedDivider(),
      ],
    );
  }
}
