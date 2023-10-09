import 'dart:async';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:places/features/add_place/data/mapper/image_source_mapper.dart';
import 'package:places/features/add_place/domain/model/image_source.dart'
    as domain;

// ignore: one_member_abstracts
abstract interface class ImagePickerApi {
  FutureOr<File?> pickImage({required domain.ImageSource source});
}

final class ImagePickerApiImpl implements ImagePickerApi {
  const ImagePickerApiImpl({
    required ImagePicker imagePicker,
  }) : _imagePicker = imagePicker;

  final ImagePicker _imagePicker;

  @override
  FutureOr<File?> pickImage({required domain.ImageSource source}) =>
      _imagePicker.pickImage(source: source.toDataModel()).then(
        (value) {
          if (value?.path == null) return null;

          return File(value!.path);
        },
      );
}
