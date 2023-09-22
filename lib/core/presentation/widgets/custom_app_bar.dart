import 'package:flutter/material.dart';

/// AppBar с кастомными параметрами.
///
/// Имеет параметры:
/// * [title] - заголовок AppBar;
/// * [titleTextStyle] - стиль заголовка;
/// * [toolbarHeight] - высота рабочей области;
/// * [padding] - отступ;
/// * [centerTitle] - признак центрирования заголовка;
/// * [leading] - левая кнопка на AppBar;
/// * [leadingWidth] - ширина пространства для левой кнопки;
/// * [actions] - кнопки в правой части AppBar.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final TextStyle? titleTextStyle;
  final double toolbarHeight;
  final EdgeInsetsGeometry? padding;
  final bool centerTitle;
  final Widget? leading;
  final double? leadingWidth;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);

  const CustomAppBar({
    super.key,
    this.title,
    this.titleTextStyle,
    required this.toolbarHeight,
    this.padding,
    this.centerTitle = false,
    this.leading,
    this.leadingWidth,
    this.actions,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null
          ? Padding(
              padding: padding ?? EdgeInsets.zero,
              child: Text(title!),
            )
          : null,
      titleTextStyle: titleTextStyle,
      toolbarHeight: toolbarHeight,
      centerTitle: centerTitle,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      leading: leading,
      leadingWidth: leadingWidth,
      actions: actions,
      bottom: bottom,
    );
  }
}
