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
/// * [onPressed] - коллбэк после нажатия кнопки;
/// * [BorderRadiusGeometry] - скругление кнопки.
/// * [gradient] - градиент цвета кнопки.
class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final Widget? buttonLabel;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final BorderRadiusGeometry? borderRadius;
  final Gradient? gradient;

  const CustomElevatedButton(
    this.text, {
    Key? key,
    this.backgroundColor,
    this.width,
    this.height,
    this.buttonLabel,
    this.textStyle,
    this.onPressed,
    this.borderRadius,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
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
          backgroundColor: backgroundColor ?? Colors.transparent,
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
