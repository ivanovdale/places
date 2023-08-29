import 'package:places/features/add_place/domain/model/image_source.dart';

enum ActionType { camera, photo, file }

extension ImageSourceMapper on ActionType {
  ImageSource toImageSource() => switch (this) {
        ActionType.camera => ImageSource.camera,
        ActionType.photo => ImageSource.gallery,
        // TODO(ivanovdale): Не реализовано.
        ActionType.file => ImageSource.gallery,
      };
}
