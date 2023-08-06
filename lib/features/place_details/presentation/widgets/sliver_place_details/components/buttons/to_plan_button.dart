import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/core/helpers/app_assets.dart';
import 'package:places/core/helpers/app_strings.dart';
import 'package:places/core/presentation/widgets/custom_buttons/custom_text_button.dart';

/// Кнопка "Запланировать" поход в указанное место.
class ToPlanButton extends StatelessWidget {
  const ToPlanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary.withOpacity(0.56);

    return CustomTextButton(
      AppStrings.toPlanText,
      textStyle: theme.textTheme.bodyMedium?.copyWith(
        color: secondaryColor,
      ),
      buttonLabel: SvgPicture.asset(
        AppAssets.calendar,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
          secondaryColor,
          BlendMode.srcIn,
        ),
      ),
      // TODO(daniiliv): Здесь будет вызов реальной функции.
      onPressed: () {
        if (kDebugMode) {
          print('"${AppStrings.toPlanText}" button pressed.');
        }
      },
    );
  }
}
