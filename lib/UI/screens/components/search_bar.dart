import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/helpers/app_assets.dart';
import 'package:places/helpers/app_strings.dart';

// TODO(daniiliv): doka
class SearchBar extends StatelessWidget {
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  const SearchBar({
    Key? key,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final secondaryColor = colorScheme.secondary.withOpacity(0.56);

    return Container(
      height: 50.0,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      child: TextField(
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          prefixIcon: SvgPicture.asset(
            AppAssets.search,
            fit: BoxFit.none,
            color: secondaryColor,
          ),
          suffixIcon: suffixIcon,
          counterText: '',
          hintText: AppStrings.search,
          hintStyle: theme.textTheme.bodyText1?.copyWith(
            color: secondaryColor,
          ),
          filled: true,
          fillColor: colorScheme.secondaryContainer,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
        ),
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }
}
