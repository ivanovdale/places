import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/core/presentation/widgets/rounded_file_image.dart';

/// Карточка добавляемой фотографии.
class NewPhotoCard extends StatelessWidget {
  final File photoFile;
  final int index;
  final ValueSetter<int> onDeletePhotoPressed;

  const NewPhotoCard({
    super.key,
    required this.photoFile,
    required this.index,
    required this.onDeletePhotoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Dismissible(
        key: ObjectKey(this),
        direction: DismissDirection.up,
        onDismissed: (direction) => onDeletePhotoPressed(index),
        child: RoundedFileImage(
          file: photoFile,
          canDelete: true,
          size: 72,
          onDelete: () => onDeletePhotoPressed(index),
        ),
      ),
    );
  }
}
