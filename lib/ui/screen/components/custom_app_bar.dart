import 'package:flutter/material.dart';

/// AppBar с кастомными параметрами.
///
/// Можно задать:
/// * [title] - заголовок AppBar;
/// * [titleTextStyle] - стиль заголовка;
/// * [centerTitle] - признак центрирования заголовка;
/// * [toolbarHeight] - высота рабочей области;
/// * [padding] - отступ.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? titleTextStyle;
  final double toolbarHeight;
  final EdgeInsetsGeometry? padding;
  final bool centerTitle;

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);

  const CustomAppBar({
    Key? key,
    required this.title,
    this.titleTextStyle,
    required this.toolbarHeight,
    this.padding,
    this.centerTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(toolbarHeight),
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: centerTitle
            ? Center(
                child: Text(
                  title,
                  style: titleTextStyle,
                ),
              )
            : ConstrainedBox(
                constraints: const BoxConstraints.expand(),
                child: Text(
                  title,
                  style: titleTextStyle,
                ),
              ),
      ),
    );
  }
}
