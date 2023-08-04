import 'package:flutter/material.dart';
import 'package:places/core/presentation/widgets/rounded_cached_network_image.dart';

/// Карточка добавляемой фотографии.
class NewPhotoCard extends StatelessWidget {
  final String photoUrl;
  final int index;
  final ValueSetter<int> onDeletePhotoPressed;

  const NewPhotoCard({
    Key? key,
    required this.photoUrl,
    required this.index,
    required this.onDeletePhotoPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Dismissible(
        key: ObjectKey(this),
        direction: DismissDirection.up,
        onDismissed: (direction) => onDeletePhotoPressed(index),
        child: RoundedCachedNetworkImage(
          url: photoUrl,
          canDelete: true,
          size: 72,
          onDelete: () => onDeletePhotoPressed(index),
        ),
      ),
    );
  }
}
