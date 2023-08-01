import 'package:flutter/material.dart';
import 'package:places/features/add_place/presentation/widgets/photo_carousel/components/add_new_photo_button.dart';
import 'package:places/features/add_place/presentation/widgets/photo_carousel/components/new_photo_card.dart';

/// Прокручиваемый список добавляемых фотографий.
///
/// Позволяет добавить/удалить фотографии из списка.
class PhotoCarousel extends StatelessWidget {
  final List<String> newPhotoList;
  final ValueSetter<String> onAddNewPhotoPressed;
  final ValueSetter<int> onDeletePhotoPressed;

  const PhotoCarousel({
    Key? key,
    required this.newPhotoList,
    required this.onAddNewPhotoPressed,
    required this.onDeletePhotoPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentPhotoIndex = 0;
    final newPhotoCards = newPhotoList
        .map(
          (photoUrl) => NewPhotoCard(
            photoUrl: photoUrl,
            index: currentPhotoIndex++,
            onDeletePhotoPressed: onDeletePhotoPressed,
          ),
        )
        .toList();

    final newPhotoCardList = <Widget>[
      AddNewPhotoButton(
        onAddNewPhotoPressed: onAddNewPhotoPressed,
      ),
      ...newPhotoCards,
    ];

    return Container(
      padding: const EdgeInsets.only(left: 16.0, top: 24),
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: newPhotoCardList,
      ),
    );
  }
}
