import 'package:flutter/material.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/utils/replace_comma_formatter.dart';
import 'package:places/features/add_place/presentation/widgets/text_fields/common/custom_text_form_field.dart';
import 'package:places/features/add_place/presentation/widgets/text_fields/latitude_text_field.dart';

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
  abstract final TextEditingController controller;
  abstract final FocusNode focusNode;
  abstract final FocusNode? nextFocusNode;
  abstract final int maxLength;
  abstract final EdgeInsets? padding;

  const BaseCoordinateTextField({
    Key? key,
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
    final regExpLat = RegExp(r'^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?)$');
    final regExpLon = RegExp(r'^[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)$');
    final regExp = this is LatitudeTextField ? regExpLat : regExpLon;

    if (value == null || value.isEmpty || !regExp.hasMatch(value)) {
      return AppStrings.coordinatesValidationMessage;
    }

    return null;
  }
}
