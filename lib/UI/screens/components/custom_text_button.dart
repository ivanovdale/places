import 'package:flutter/material.dart';

/// Кастомная текстовая кнопка.
///
/// Имеет параметры:
/// * [text] - текст кнопки (обязательный);
/// * [textStyle] - стиль текста кнопки;
/// * [buttonLabel] - виджет-лейбл кнопки;
/// * [padding] - отступ для кнопки;
/// * [onPressed] - коллбэк после нажатия кнопки;
/// * [alignment] - расположение текста кнопки.
class CustomTextButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Widget? buttonLabel;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final AlignmentGeometry? alignment;

  const CustomTextButton(
    this.text, {
    Key? key,
    this.buttonLabel,
    this.textStyle,
    this.padding,
    this.onPressed,
    this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: padding ?? EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: alignment,
      ),
      child: buttonLabel != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                buttonLabel!,
                const SizedBox(
                  width: 9,
                ),
                Text(
                  text,
                  style: textStyle,
                ),
              ],
            )
          : Text(
              text,
              style: textStyle,
            ),
    );
  }
}
