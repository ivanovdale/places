import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Отображает плейсхолдер с информацией.
///
/// Для ошибок/предупреждений.
abstract class InfoPlaceHolder extends StatelessWidget {
  final double iconSize;
  abstract final String iconPath;
  abstract final String infoText;
  abstract final String descriptionText;

  const InfoPlaceHolder({
    Key? key,
    required this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final secondaryColor = theme.colorScheme.secondary.withOpacity(0.56);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iconPath,
          height: iconSize,
          width: iconSize,
          color: secondaryColor,
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          infoText,
          style: textTheme.subtitle1?.copyWith(
            color: secondaryColor,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          descriptionText,
          style: textTheme.bodyText2?.copyWith(
            color: secondaryColor,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
