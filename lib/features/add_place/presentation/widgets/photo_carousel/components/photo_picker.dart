import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/custom_elevated_button.dart';
import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/features/add_place/presentation/widgets/photo_carousel/components/add_photo_actions.dart';

/// Позволяет выбрать фото из камеры, галереи или файлов.
class PhotoPicker extends StatelessWidget {
  /// Действия добавления фотографии.
  List<Map<String, String>> get actions => [
    {
      'icon': AppAssets.camera,
      'text': AppStrings.camera,
    },
    {
      'icon': AppAssets.photo,
      'text': AppStrings.photo,
    },
    {
      'icon': AppAssets.file,
      'text': AppStrings.file,
    },
  ];

  const PhotoPicker({Key? key}) : super(key: key);

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
            AddPhotoActions(actions: actions),
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