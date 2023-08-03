import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_strings.dart';

/// Задний фон, когда происходит свайп карточки влево для удаления.
class BackgroundOnDismiss extends StatelessWidget {
  final bool isDraggingActive;

  const BackgroundOnDismiss({
    Key? key,
    required this.isDraggingActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return !isDraggingActive
        ? AspectRatio(
            aspectRatio: 3 / 2,
            child: Container(
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                color: AppColors.flamingo,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.only(
                right: 16.0,
                bottom: 16.0,
                top: 16.0,
              ),
              margin: const EdgeInsets.only(bottom: 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.delete,
                    width: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      AppStrings.delete,
                      style: theme.textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
