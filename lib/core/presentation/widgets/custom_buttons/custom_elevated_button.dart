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
/// * [borderRadius] - скругление кнопки;
/// * [gradient] - градиент цвета кнопки;
/// * [padding] - отступ внутри кнопки.
class CustomElevatedButton extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final Widget? buttonLabel;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final BorderRadiusGeometry? borderRadius;
  final Gradient? gradient;
  final EdgeInsetsGeometry? padding;

  const CustomElevatedButton({
    super.key,
    this.text,
    this.backgroundColor,
    this.width,
    this.height,
    this.buttonLabel,
    this.textStyle,
    this.onPressed,
    this.borderRadius,
    this.gradient,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final hasTextAndButtonLabel = text != null && buttonLabel != null;

    Widget childWidget;
    if (hasTextAndButtonLabel) {
      childWidget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buttonLabel!,
          const SizedBox(
            width: 10,
          ),
          Text(
            text!,
            style: textStyle,
          ),
        ],
      );
    } else if (text != null) {
      childWidget = Text(
        text!,
        style: textStyle,
      );
    } else if (buttonLabel != null) {
      childWidget = buttonLabel!;
    } else {
      childWidget = const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed ??
            () {
              if (kDebugMode) {
                print('"$text" button pressed.');
              }
            },
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
          ),
          padding: padding
        ),
        child: childWidget,
      ),
    );
  }
}
