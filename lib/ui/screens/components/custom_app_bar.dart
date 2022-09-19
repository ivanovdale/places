import 'package:flutter/material.dart';

/// AppBar с кастомными параметрами.
///
/// Имеет параметры:
/// * [title] - заголовок AppBar;
/// * [titleTextStyle] - стиль заголовка;
/// * [toolbarHeight] - высота рабочей области;
/// * [padding] - отступ;
/// * [centerTitle] - признак центрирования заголовка.
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
    return AppBar(
      title: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Text(title),
      ),
      titleTextStyle: titleTextStyle,
      toolbarHeight: toolbarHeight,
      centerTitle: centerTitle,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
    );
  }
}
