import 'package:flutter/material.dart';
import 'package:places/features/add_place/presentation/widgets/text_fields/common/base_coordinate_text_field.dart';

/// Поле ввода широты координат места.
///
/// Задаёт следующим полем для ввода - поле ввода долготы координат места.
/// Максимальная длина поля - 9 символов.
class LatitudeTextField extends BaseCoordinateTextField {
  final TextEditingController latitudeController;
  final FocusNode latitudeFocusNode;
  final FocusNode longitudeFocusNode;

  @override
  TextEditingController get controller => latitudeController;

  @override
  FocusNode get focusNode => latitudeFocusNode;

  @override
  FocusNode? get nextFocusNode => longitudeFocusNode;

  @override
  int get maxLength => 9;

  @override
  EdgeInsets? get padding => const EdgeInsets.only(
        left: 16,
        right: 8,
      );

  const LatitudeTextField({
    super.key,
    required this.latitudeController,
    required this.latitudeFocusNode,
    required this.longitudeFocusNode,
  });
}
