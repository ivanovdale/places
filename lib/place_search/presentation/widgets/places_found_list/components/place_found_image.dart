import 'package:flutter/material.dart';
import 'package:places/UI/screens/components/rounded_cached_network_image.dart';
import 'package:places/domain/model/place.dart';

/// Картинка найденного места.
class PlaceFoundImage extends StatelessWidget {
  /// Картинка по умолчанию.
  static const defaultImageUrl =
      'https://wallbox.ru/resize/1024x768/wallpapers/main2/201726/pole12.jpg';

  final Place place;

  const PlaceFoundImage({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedCachedNetworkImage(
      size: 56,
      borderRadius: BorderRadius.circular(12),
      url: place.photoUrlList?[0] ?? defaultImageUrl,
    );
  }
}
