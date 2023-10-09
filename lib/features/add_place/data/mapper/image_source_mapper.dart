import 'package:image_picker/image_picker.dart';
import 'package:places/features/add_place/domain/model/image_source.dart'
    as domain;

extension ImageSourceExt on domain.ImageSource {
  ImageSource toDataModel() => switch (this) {
        domain.ImageSource.camera => ImageSource.camera,
        domain.ImageSource.gallery => ImageSource.gallery,
      };
}
