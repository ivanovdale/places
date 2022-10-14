import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Кнопка с картинкой с заданными параметрами.
///
/// Параметры:
/// * [icon] - иконка кнопки;
/// * [size] - размер иконки;
/// * [color] - цвет иконки;
/// * [padding] - отступ иконки кнопки;
/// * [onPressed] - коллбэк после нажатия кнопки.
class CustomIconButton extends StatelessWidget {
  final IconData? icon;
  final double? size;
  final Color? color;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;

  const CustomIconButton({
    Key? key,
    this.icon,
    this.size,
    this.color,
    this.padding,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ??
          () {
            if (kDebugMode) {
              print('button pressed.');
            }
          },
      icon: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Icon(
          icon,
          size: size,
          color: color,
        ),
      ),
    );
  }
}
