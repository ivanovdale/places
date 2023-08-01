import 'package:flutter/material.dart';
import 'package:places/features/add_place/presentation/widgets/labels/latitude_label.dart';
import 'package:places/features/add_place/presentation/widgets/labels/longitude_label.dart';
import 'package:places/features/add_place/presentation/widgets/text_fields/latitude_text_field.dart';
import 'package:places/features/add_place/presentation/widgets/text_fields/longitude_text_field.dart';

/// Поля ввода координат места.
class MapTextFields extends StatelessWidget {
  final TextEditingController latitudeController;
  final TextEditingController longitudeController;
  final FocusNode latitudeFocusNode;
  final FocusNode longitudeFocusNode;
  final FocusNode descriptionFocusNode;

  const MapTextFields({
    Key? key,
    required this.latitudeController,
    required this.latitudeFocusNode,
    required this.longitudeFocusNode,
    required this.longitudeController,
    required this.descriptionFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LatitudeLabel(),
              LatitudeTextField(
                latitudeController: latitudeController,
                latitudeFocusNode: latitudeFocusNode,
                longitudeFocusNode: longitudeFocusNode,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LongitudeLabel(),
              LongitudeTextField(
                longitudeController: longitudeController,
                longitudeFocusNode: longitudeFocusNode,
                descriptionFocusNode: descriptionFocusNode,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
