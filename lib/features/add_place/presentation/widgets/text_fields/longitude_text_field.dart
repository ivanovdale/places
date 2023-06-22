import 'package:flutter/material.dart';
import 'package:places/features/add_place/presentation/add_place_screen.dart';
import 'package:places/features/add_place/presentation/widgets/text_fields/common/base_coordinate_text_field.dart';

/// Поле ввода долготы координат места.
///
/// Задаёт следующим полем для ввода - поле ввода описания места.
/// Максимальная длина поля - 10 символов.
class LongitudeTextField extends BaseCoordinateTextField {
  @override
  AddPlaceBodyState get dataStorage => InheritedAddPlaceBodyState.of(context);

  @override
  TextEditingController get controller => dataStorage.longitudeController;

  @override
  FocusNode get focusNode => dataStorage.longitudeFocusNode;

  @override
  FocusNode? get nextFocusNode => dataStorage.descriptionFocusNode;

  @override
  int get maxLength => 10;

  @override
  EdgeInsets? get padding => const EdgeInsets.only(
        left: 8.0,
        right: 16.0,
      );

  const LongitudeTextField({
    Key? key,
    required BuildContext context,
  }) : super(
          key: key,
          context: context,
        );
}
