import 'package:flutter/material.dart';
import 'package:places/features/add_place/presentation/add_place_screen.dart';
import 'package:places/features/add_place/presentation/widgets/text_fields/common/custom_text_form_field.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/utils/replace_comma_formatter.dart';

/// Абстрактный класс для ввода координат места.
///
/// Валидирует поля ввода, позволяя вводить только десятичные числа.
/// Перемещает фокус на следующее поле при окончании редактирования.
/// Необходимо переопределить в потомках:
/// * [controller] - контроллер данного поля ввода;
/// * [focusNode] - фокусноду данного поля ввода;
/// * [nextFocusNode] - фокусноду, на которую необходимо переключиться после окончания ввода текста;
/// * [maxLength] - максимальную длину поля;
/// * [padding] - отступ для поля.
abstract class BaseCoordinateTextField extends StatelessWidget {
  final BuildContext context;
  abstract final AddPlaceBodyState dataStorage;
  abstract final TextEditingController controller;
  abstract final FocusNode focusNode;
  abstract final FocusNode? nextFocusNode;
  abstract final int maxLength;
  abstract final EdgeInsets? padding;

  const BaseCoordinateTextField({
    Key? key,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      focusNode: focusNode,
      nextFocusNode: nextFocusNode,
      height: 40,
      maxLength: maxLength,
      padding: padding,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        ReplaceCommaFormatter(),
      ],
      validator: coordinatePointValidator,
    );
  }

  /// Валидирует поля ввода, позволяя вводить только десятичные числа.
  String? coordinatePointValidator(String? value) {
    final digitsAndDots = RegExp(r'^(?=\D*(?:\d\D*){1,10}$)\d+(?:\.\d{1,7})?$');

    if (value == null || value.isEmpty || !digitsAndDots.hasMatch(value)) {
      return AppStrings.coordinatesValidationMessage;
    }

    return null;
  }
}