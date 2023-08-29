import 'dart:async';
import 'dart:io';

import 'package:places/features/add_place/domain/model/image_source.dart';

abstract interface class PhotoRepository {
  /// Возвращает выбранный файл.
  FutureOr<File?> pickImage({required ImageSource source});

  /// Возвращает список url загруженных картинок.
  Future<List<String>> uploadImages(List<File> images);
}
