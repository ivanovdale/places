import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/presentation/widgets/error_icon.dart';

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
        return Hero(
          tag: 'place_card_${place.id}',
          // Для исправления ошибки с Image.Ink.
          flightShuttleBuilder: (_, __, ___, ____, toHeroContext) => Material(
            child: toHeroContext.widget,
          ),
          child: CachedNetworkImage(
            imageUrl: place.photoUrlList?[index] ?? defaultImageUrl,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (_, __, downloadProgress) => Center(
              child: CupertinoActivityIndicator.partiallyRevealed(
                progress: downloadProgress.progress ?? 0,
              ),
            ),
            errorWidget: (_, __, ___) => const ErrorIcon(),
          ),
        );
      },
    );
  }
}
