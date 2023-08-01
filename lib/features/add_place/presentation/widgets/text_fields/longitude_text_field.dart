import 'package:flutter/material.dart';
import 'package:places/features/add_place/presentation/widgets/text_fields/common/base_coordinate_text_field.dart';

/// Поле ввода долготы координат места.
///
/// Задаёт следующим полем для ввода - поле ввода описания места.
/// Максимальная длина поля - 10 символов.
class LongitudeTextField extends BaseCoordinateTextField {
  final TextEditingController longitudeController;
  final FocusNode longitudeFocusNode;
  final FocusNode descriptionFocusNode;

  @override
  TextEditingController get controller => longitudeController;

  @override
  FocusNode get focusNode => longitudeFocusNode;

  @override
  FocusNode? get nextFocusNode => descriptionFocusNode;

  @override
  int get maxLength => 10;

  @override
  EdgeInsets? get padding => const EdgeInsets.only(
        left: 8.0,
        right: 16.0,
      );

  const LongitudeTextField({
    super.key,
    required this.longitudeController,
    required this.longitudeFocusNode,
    required this.descriptionFocusNode,
  });
}
