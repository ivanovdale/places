import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/presentation/widgets/utils/image_error_helper.dart';
import 'package:places/core/presentation/widgets/utils/loading_indicator_helper.dart';

/// Галерея фотографии места.
class PhotoGallery extends StatelessWidget {
  /// Картинка по умолчанию.
  static const defaultImageUrl =
      'https://wallbox.ru/resize/1024x768/wallpapers/main2/201726/pole12.jpg';

  final ValueSetter<int>? onPageChanged;
  final PageController controller;
  final Place place;

  const PhotoGallery({
    super.key,
    this.onPageChanged,
    required this.controller,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      onPageChanged: onPageChanged,
      itemCount: place.photoUrlList?.length,
      itemBuilder: (_, index) {
        return CachedNetworkImage(
          imageUrl: place.photoUrlList?[index] ?? defaultImageUrl,
          fit: BoxFit.cover,
          progressIndicatorBuilder:
              LoadingIndicatorHelper.progressIndicatorBuilder,
          errorWidget: ImageErrorHelper.errorIcon,
        );
      },
    );
  }
}
