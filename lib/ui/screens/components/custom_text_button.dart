import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Кастомная текстовая кнопка.
///
/// Имеет параметры:
/// * [text] - текст кнопки (обязательный);
/// * [textStyle] - стиль текста кнопки;
/// * [buttonLabel] - виджет-лейбл кнопки;
/// * [padding] - отступ для кнопки;
/// * [onPressed] - коллбэк после нажатия кнопки.
class CustomTextButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Widget? buttonLabel;
  final EdgeInsetsGeometry? padding;
  final Function()? onPressed;

  const CustomTextButton(
    this.text, {
    Key? key,
    this.buttonLabel,
    this.textStyle,
    this.padding,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // TODO(daniiliv): Здесь будет вызов реальной функции.
      onPressed: onPressed ??
          () {
            if (kDebugMode) {
              print('"$text" button pressed.');
            }
          },
      style: TextButton.styleFrom(
        padding: padding ?? EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
