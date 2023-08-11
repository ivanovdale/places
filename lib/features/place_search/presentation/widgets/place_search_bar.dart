import 'package:flutter/material.dart';
import 'package:places/core/presentation/widgets/search_bar.dart'
    as custom_search_bar;

/// Поле ввода для поиска мест.
class PlaceSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onPressed;

  const PlaceSearchBar({
    super.key,
    this.controller,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return custom_search_bar.SearchBar(
      controller: controller,
      autofocus: true,
      suffixIcon: IconButton(
        icon: const Icon(Icons.cancel),
        color: theme.primaryColorDark,
        onPressed: onPressed,
      ),
    );
  }
}
