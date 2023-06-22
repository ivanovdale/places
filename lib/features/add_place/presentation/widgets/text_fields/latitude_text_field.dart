import 'package:flutter/material.dart';
import 'package:places/features/add_place/presentation/add_place_screen.dart';
import 'package:places/features/add_place/presentation/widgets/text_fields/common/base_coordinate_text_field.dart';

/// Поле ввода широты координат места.
///
/// Задаёт следующим полем для ввода - поле ввода долготы координат места.
/// Максимальная длина поля - 9 символов.
class LatitudeTextField extends BaseCoordinateTextField {
  @override
  AddPlaceBodyState get dataStorage => InheritedAddPlaceBodyState.of(context);

  @override
  TextEditingController get controller => dataStorage.latitudeController;

  @override
  FocusNode get focusNode => dataStorage.latitudeFocusNode;

  @override
  FocusNode? get nextFocusNode => dataStorage.longitudeFocusNode;

  @override
  int get maxLength => 9;

  @override
  EdgeInsets? get padding => const EdgeInsets.only(
        left: 16.0,
        right: 8.0,
      );

  const LatitudeTextField({
    Key? key,
    required BuildContext context,
  }) : super(
          key: key,
          context: context,
        );
}
