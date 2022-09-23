import 'package:flutter/material.dart';

/// Разделитель с возможностью задать его отступ [padding] и толщину [thickness].
class CustomDivider extends StatelessWidget {
  final EdgeInsets? padding;
  final double? thickness;

  const CustomDivider({
    Key? key,
    this.padding,
    required this.thickness,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Divider(
        thickness: thickness ?? 1.0,
      ),
    );
  }
}
