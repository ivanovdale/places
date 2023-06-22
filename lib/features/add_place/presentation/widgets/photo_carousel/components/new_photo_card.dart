import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/rounded_cached_network_image.dart';
import 'package:places/features/add_place/presentation/add_place_screen.dart';

/// Карточка добавляемой фотографии.
class NewPhotoCard extends StatelessWidget {
  final String photoUrl;
  final int index;

  const NewPhotoCard({
    Key? key,
    required this.photoUrl,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Dismissible(
        key: ObjectKey(this),
        direction: DismissDirection.up,
        onDismissed: (direction) => deletePhotoFromList(context),
        child: RoundedCachedNetworkImage(
          url: photoUrl,
          canDelete: true,
          size: 72,
          onDelete: () => deletePhotoFromList(context),
        ),
      ),
    );
  }

  /// Удаляет фото из списка добавляемых фото.
  void deletePhotoFromList(BuildContext context) {
    InheritedAddPlaceBodyState.of(context).deletePhotoFromList(index);
  }
}