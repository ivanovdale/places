import 'package:flutter/material.dart';
import 'package:places/features/add_place/domain/model/image_source.dart';
import 'package:places/features/add_place/domain/model/photo_action_type.dart';
import 'package:places/features/add_place/presentation/widgets/photo_carousel/components/photo_picker.dart';

/// Кнопка добавления новой фотографии.
class AddNewPhotoButton extends StatelessWidget {
  final ValueSetter<ImageSource> onAddNewPhotoPressed;

  const AddNewPhotoButton({
    super.key,
    required this.onAddNewPhotoPressed,
  });

  /// Открывает диалог для добавления нового фото в список добавляемых фото.
  Future<void> _showImagePicker(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => PhotoPicker(
        onActionPressed: (action) => onAddNewPhotoPressed(
          action.type.toImageSource(),
        ),
        closeOnPressed: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorSchemePrimaryColor = theme.colorScheme.primary;

    return GestureDetector(
      onTap: () => _showImagePicker(context),
      child: Container(
        width: 72,
        height: 72,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colorSchemePrimaryColor.withOpacity(0.48),
            width: 2,
          ),
        ),
        child: Icon(
          Icons.add,
          size: 45,
          color: colorSchemePrimaryColor,
        ),
      ),
    );
  }
}
