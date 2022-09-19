import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Кастомная текстовая кнопка.
///
/// Имеет параметры:
/// * [text] - текст кнопки (обязательный);
/// * [textStyle] - стиль текста кнопки;
/// * [buttonLabel] - виджет-лейбл кнопки.
class CustomTextButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Widget? buttonLabel;

  const CustomTextButton(
    this.text, {
    Key? key,
    this.buttonLabel,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // TODO(daniiliv): Здесь будет вызов реальной функции.
      onPressed: () {
        if (kDebugMode) {
          print('"$text" button pressed.');
        }
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        alignment: Alignment.topCenter,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: const Size.fromHeight(24),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          buttonLabel ?? const SizedBox(),
          const SizedBox(
            width: 9,
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
