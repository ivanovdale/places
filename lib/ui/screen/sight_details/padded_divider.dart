import 'package:flutter/material.dart';

class PaddedDivider extends StatelessWidget {
  final double top;
  final double left;
  final double right;
  final double bottom;
  final double thickness;

  const PaddedDivider({
    Key? key,
    required this.top,
    required this.left,
    required this.right,
    required this.bottom,
    required this.thickness,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: top,
        left: left,
        right: right,
        bottom: bottom,
      ),
      child: Divider(
        thickness: thickness,
      ),
    );
  }
}
