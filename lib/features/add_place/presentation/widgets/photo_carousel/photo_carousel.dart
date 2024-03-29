import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/features/add_place/domain/model/image_source.dart';
import 'package:places/features/add_place/presentation/widgets/photo_carousel/components/add_new_photo_button.dart';
import 'package:places/features/add_place/presentation/widgets/photo_carousel/components/new_photo_card.dart';

/// Прокручиваемый список добавляемых фотографий.
///
/// Позволяет добавить/удалить фотографии из списка.
class PhotoCarousel extends StatelessWidget {
  final List<File> photoList;
  final ValueSetter<ImageSource> onAddNewPhotoPressed;
  final ValueSetter<int> onDeletePhotoPressed;

  const PhotoCarousel({
    super.key,
    required this.photoList,
    required this.onAddNewPhotoPressed,
    required this.onDeletePhotoPressed,
  });

  @override
  Widget build(BuildContext context) {
    var currentPhotoIndex = 0;
    final newPhotoCards = photoList
        .map(
          (photoFile) => NewPhotoCard(
            photoFile: photoFile,
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

    return SizedBox(
      height: 100,
      child: ListView(
        padding: const EdgeInsets.only(left: 16, top: 24),
        scrollDirection: Axis.horizontal,
        children: newPhotoCardList,
      ),
    );
  }
}
