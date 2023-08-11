import 'package:flutter/material.dart';
import 'package:places/core/presentation/widgets/placeholders/places_not_found_placeholder.dart';

/// Информация о том, что места не найдены.
class PlacesNotFoundInfo extends StatelessWidget {
  const PlacesNotFoundInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: PlacesNotFoundPlaceHolder(),
    );
  }
}
