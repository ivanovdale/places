import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Кастомная выпуклая кнопка.
///
/// Имеет параметры:
/// * [text] - текст кнопки (обязательный);
/// * [backgroundColor] - цвет фона кнопки;
/// * [width] - ширина;
/// * [height] - высота;
/// * [buttonLabel] - виджет-лейбл кнопки;
/// * [textStyle] - стиль текста кнопки;
/// * [onPressed] - коллбэк после нажатия кнопки.
class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final Widget? buttonLabel;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;

  const CustomElevatedButton(
    this.text, {
    Key? key,
    this.backgroundColor,
    this.width,
    this.height,
    this.buttonLabel,
    this.textStyle,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        // TODO(daniiliv): Здесь будет вызов реальной функции.
        onPressed: onPressed ??
            () {
              if (kDebugMode) {
                print('"$text" button pressed.');
              }
            },
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buttonLabel ?? const SizedBox(),
            // Если есть лейбл кнопки, то сделать отступ.
            if (buttonLabel != null)
              const SizedBox(
                width: 10,
              ),
            Text(
              text,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
