import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/core/helpers/app_colors.dart';

/// Произвольное поле ввода с настройками.
class CustomTextFormField extends StatefulWidget {
  final EdgeInsets? padding;
  final double? height;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final int maxLength;
  final bool autofocus;
  final bool unFocusWhenEditingComplete;
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
    this.unFocusWhenEditingComplete = false,
    this.hintText,
    this.maxLines = 1,
    this.hintStyle,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_focusNodeListener);
  }

  /// Необходим для появления кнопки очистки поля.
  void _focusNodeListener() {
    setState(() {});
  }

  /// Выполняет активацию нужного поля в зависимости от условия.
  ///
  /// Если определено поле следующего фокуса, то устанавливает его в качестве следующего поля ввода.
  /// Иначе если установлен признак отключения фокуса при завершении редактирования поля, то выполняет данное действие.
  void _changeFocus() {
    if (widget.nextFocusNode != null) {
      widget.nextFocusNode!.requestFocus();
    } else if (widget.unFocusWhenEditingComplete) {
      widget.focusNode.unfocus();
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.focusNode.removeListener(_focusNodeListener);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorSchemePrimaryColor = theme.colorScheme.primary.withOpacity(0.4);

    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: SizedBox(
        height: widget.height ?? 0,
        child: TextFormField(
          validator: widget.validator,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          autofocus: widget.autofocus,
          textInputAction:
              (widget.maxLines ?? 0) > 1 ? TextInputAction.done : null,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          focusNode: widget.focusNode,
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            errorStyle: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.flamingo,
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.flamingo),
            ),
            counterText: '',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorSchemePrimaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: colorSchemePrimaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: widget.focusNode.hasFocus
                ? IconButton(
                    icon: const Icon(Icons.cancel),
                    color: theme.primaryColorDark,
                    onPressed: widget.controller.clear,
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
