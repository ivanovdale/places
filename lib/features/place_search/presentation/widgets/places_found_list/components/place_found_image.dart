import 'package:flutter/material.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/presentation/widgets/rounded_cached_network_image.dart';

/// Картинка найденного места.
class PlaceFoundImage extends StatelessWidget {
  /// Картинка по умолчанию.
  static const defaultImageUrl =
      'https://wallbox.ru/resize/1024x768/wallpapers/main2/201726/pole12.jpg';

  final Place place;

  const PlaceFoundImage({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedCachedNetworkImage(
      size: 56,
      borderRadius: BorderRadius.circular(12),
      url: place.photoUrlList?[0] ?? defaultImageUrl,
    );
  }
}
