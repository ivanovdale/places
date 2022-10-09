import 'package:flutter/material.dart';

/// Разделитель с возможностью задать его отступ [padding],
/// толщину [thickness] и цвет [color].
class CustomDivider extends StatelessWidget {
  final EdgeInsets? padding;
  final double? thickness;
  final Color? color;

  const CustomDivider({
    Key? key,
    this.padding,
    this.thickness,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Divider(
        thickness: thickness ?? 1.0,
        color: color,
      ),
    );
  }
}
