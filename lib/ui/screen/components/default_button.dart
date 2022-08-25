import 'package:flutter/material.dart';

/// Кнопка "Построить маршрут".
/// Предоставляет возможность построить маршрут к достопримечательности.
class DefaultButton extends StatelessWidget {
  final Color? color;
  final double? width;
  final double? height;
  final Widget? buttonLabel;
  final String text;
  final TextStyle? textStyle;

  const DefaultButton({
    Key? key,
    this.color,
    this.height,
    this.width,
    this.buttonLabel,
    this.textStyle,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
      ),
      height: height,
      width: width,
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
    );
  }
}
