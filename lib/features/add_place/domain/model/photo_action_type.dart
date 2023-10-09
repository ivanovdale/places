import 'package:places/features/add_place/domain/model/image_source.dart';

enum PhotoActionType { camera, photo, file }

extension ImageSourceMapper on PhotoActionType {
  ImageSource toImageSource() => switch (this) {
        PhotoActionType.camera => ImageSource.camera,
        PhotoActionType.photo => ImageSource.gallery,
        // TODO(ivanovdale): Не реализовано.
        PhotoActionType.file => ImageSource.gallery,
      };
}
