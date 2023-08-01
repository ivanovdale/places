import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Произвольное поле ввода с настройками.
class CustomTextFormField extends StatelessWidget {
  final EdgeInsets? padding;
  final double? height;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final int maxLength;
  final bool autofocus;
  final bool unfocusWhenEditingComplete;
  final String? hintText;
  final TextStyle? hintStyle;
  final int? maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    Key? key,
    this.padding,
    this.height,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    required this.maxLength,
    this.autofocus = false,
    this.unfocusWhenEditingComplete = false,
    this.hintText,
    this.maxLines = 1,
    this.hintStyle,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
  }) : super(key: key);

  /// Выполняет активацию нужного поля в зависимости от условия.
  ///
  /// Если определено поле следующего фокуса, то устанавливает его в качестве следующего поля ввода.
  /// Иначе если установлен признак отключения фокуса при завершении редактирования поля, то выполняет данное действие.
  void _changeFocus() {
    if (nextFocusNode != null) {
      nextFocusNode!.requestFocus();
    } else if (unfocusWhenEditingComplete) {
      focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorSchemePrimaryColor = theme.colorScheme.primary.withOpacity(0.4);

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SizedBox(
        height: height ?? 0,
        child: TextFormField(
          validator: validator,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          autofocus: autofocus,
          textInputAction: (maxLines ?? 0) > 1 ? TextInputAction.done : null,
          maxLines: maxLines,
          maxLength: maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          focusNode: focusNode,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: hintStyle,
            counterText: '',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorSchemePrimaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: colorSchemePrimaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: focusNode.hasFocus
                ? IconButton(
                    icon: const Icon(Icons.cancel),
                    color: theme.primaryColorDark,
                    onPressed: controller.clear,
                  )
                : null,
          ),
          textAlignVertical: TextAlignVertical.top,
          style: theme.textTheme.bodyLarge,
          onEditingComplete: _changeFocus,
        ),
      ),
    );
  }
}
