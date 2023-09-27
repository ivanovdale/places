import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/core/presentation/widgets/custom_pickers/custom_action_picker/components/picker_actions.dart';
import 'package:places/features/add_place/presentation/widgets/photo_carousel/components/add_photo_action_padded_divider.dart';
import 'package:places/features/map/domain/model/map_type.dart';

class ActionItem<T> extends StatelessWidget {
  final ActionElement<T> action;
  final ValueSetter<ActionElement<T>> onActionPressed;
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
              if (action.icon != null)
                SvgPicture.asset(
                  action.icon!,
                  height: 24,
                  colorFilter: action.type is MapType
                      ? null
                      : ColorFilter.mode(
                          secondaryColor,
                          BlendMode.srcIn,
                        ),
                ),
              if (action.icon != null)
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
