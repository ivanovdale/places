import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/features/add_place/presentation/widgets/photo_carousel/components/add_photo_action_padded_divider.dart';

/// Действие добавления новой фотографии.
class ActionItem extends StatelessWidget {
  final String text;
  final String iconAsset;
  final bool isLastItem;

  const ActionItem({
    Key? key,
    required this.text,
    required this.iconAsset,
    required this.isLastItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            if (kDebugMode) {
              print('$text button pressed.');
            }
          },
          child: Row(
            children: [
              SvgPicture.asset(
                iconAsset,
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
                text,
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