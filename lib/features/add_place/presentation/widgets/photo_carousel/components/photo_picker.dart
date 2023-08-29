import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/custom_buttons/custom_elevated_button.dart';
import 'package:places/features/add_place/domain/action_type.dart';
import 'package:places/features/add_place/presentation/widgets/photo_carousel/components/add_photo_actions.dart';

typedef ActionElement = ({String icon, String text, ActionType type});

/// Позволяет выбрать фото из камеры, галереи или файлов.
class PhotoPicker extends StatelessWidget {
  /// Действия добавления фотографии.
  List<ActionElement> get _actions => [
        (
          icon: AppAssets.camera,
          text: AppStrings.camera,
          type: ActionType.camera,
        ),
        (
          icon: AppAssets.photo,
          text: AppStrings.photo,
          type: ActionType.photo,
        ),
        (
          icon: AppAssets.file,
          text: AppStrings.file,
          type: ActionType.file,
        ),
      ];

  const PhotoPicker({super.key});

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
            AddPhotoActions(actions: _actions),
            const SizedBox(
              height: 8,
            ),
            CustomElevatedButton(
              AppStrings.cancel,
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
