import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/custom_icon_button.dart';

/// Скругленная картинка, загруженная из интернета с кастомными параметрами.
class RoundedCachedNetworkImage extends StatelessWidget {
  final String url;
  final double? size;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback? onDelete;
  final bool canDelete;

  const RoundedCachedNetworkImage({
    Key? key,
    required this.url,
    this.size,
    this.borderRadius,
    this.onDelete,
    this.canDelete = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
        // Use here borderRadius
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        child: Material(
          child: Ink.image(
            padding: EdgeInsets.zero,
            fit: BoxFit.cover,
            width: size,
            height: size,
            image: CachedNetworkImageProvider(url),
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
