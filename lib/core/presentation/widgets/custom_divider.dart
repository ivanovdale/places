import 'package:flutter/material.dart';

/// Разделитель с возможностью задать его отступ [padding],
/// толщину [thickness], цвет [color], высоту [height].
class CustomDivider extends StatelessWidget {
  final EdgeInsets? padding;
  final double? thickness;
  final Color? color;
  final double? height;

  const CustomDivider({
    Key? key,
    this.padding,
    this.thickness,
    this.color,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Divider(
        thickness: thickness ?? 1.0,
        color: color,
        height: height,
      ),
    );
  }
}
