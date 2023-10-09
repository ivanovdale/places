import 'dart:async';
import 'dart:io';

import 'package:places/features/add_place/domain/model/image_source.dart';
import 'package:places/features/add_place/domain/repository/photo_repository.dart';

final class PhotoInteractor {
  final PhotoRepository _photoRepository;

  const PhotoInteractor({
    required PhotoRepository photoRepository,
  }) : _photoRepository = photoRepository;

  FutureOr<File?> pickImage({required ImageSource source}) =>
      _photoRepository.pickImage(source: source);

  FutureOr<List<String>> uploadImages(List<File> images) =>
      _photoRepository.uploadImages(images);
}
