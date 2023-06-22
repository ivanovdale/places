import 'package:flutter/material.dart';
import 'package:places/features/add_place/presentation/add_place_screen.dart';
import 'package:places/features/add_place/presentation/widgets/photo_carousel/components/add_new_photo_button.dart';
import 'package:places/features/add_place/presentation/widgets/photo_carousel/components/new_photo_card.dart';

/// Прокручиваемый список добавляемых фотографий.
///
/// Позволяет добавить/удалить фотографии из списка.
class PhotoCarousel extends StatelessWidget {
  const PhotoCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataStorage = InheritedAddPlaceBodyState.of(context);

    var currentPhotoIndex = 0;
    final newPhotoList = dataStorage.newPhotoList;
    List<Widget> newPhotoCardList;
    newPhotoCardList = newPhotoList
        .map((photoUrl) {
          return NewPhotoCard(
            photoUrl: photoUrl,
            index: currentPhotoIndex++,
          );
        })
        .cast<Widget>()
        .toList()
      ..insert(0, const AddNewPhotoButton());

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
