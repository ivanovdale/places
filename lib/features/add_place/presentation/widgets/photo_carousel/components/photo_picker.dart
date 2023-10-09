import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/custom_pickers/custom_action_picker/components/picker_actions.dart';
import 'package:places/core/presentation/widgets/custom_pickers/custom_action_picker/custom_action_picker.dart';
import 'package:places/features/add_place/domain/model/photo_action_type.dart';

/// Позволяет выбрать фото из камеры, галереи или файлов.
class PhotoPicker extends StatelessWidget {
  const PhotoPicker({
    super.key,
    required this.onActionPressed,
    required this.closeOnPressed,
  });

  final ValueSetter<ActionElement<PhotoActionType>> onActionPressed;
  final bool closeOnPressed;

  @override
  Widget build(BuildContext context) {
    return CustomActionPicker<PhotoActionType>(
      onActionPressed: onActionPressed,
      closeOnPressed: closeOnPressed,
      actions: const [
        (
          icon: AppAssets.camera,
          text: AppStrings.camera,
          type: PhotoActionType.camera,
        ),
        (
          icon: AppAssets.photo,
          text: AppStrings.photo,
          type: PhotoActionType.photo,
        ),
        (
          icon: AppAssets.file,
          text: AppStrings.file,
          type: PhotoActionType.file,
        ),
      ],
    );
  }
}
