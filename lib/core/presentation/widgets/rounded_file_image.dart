import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/core/presentation/widgets/custom_buttons/custom_icon_button.dart';

/// Скругленная картинка, загруженная из файла с кастомными параметрами.
class RoundedFileImage extends StatelessWidget {
  final File file;
  final double? size;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback? onDelete;
  final bool canDelete;

  const RoundedFileImage({
    super.key,
    required this.file,
    this.size,
    this.borderRadius,
    this.onDelete,
    this.canDelete = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        child: Material(
          child: Ink.image(
            padding: EdgeInsets.zero,
            fit: BoxFit.cover,
            width: size,
            height: size,
            image: FileImage(file),
          ),
        ),
      ),
      // Если стоит признак возможности удаления, то добавить кнопку удаления.
      if (canDelete)
        Positioned(
          right: -7,
          top: -7,
          child: CustomIconButton(
            icon: Icons.cancel,
            color: Theme.of(context).colorScheme.onBackground,
            onPressed: onDelete,
          ),
        )
      else
        const SizedBox(),
    ]);
  }
}
