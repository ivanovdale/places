import 'package:flutter/material.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/helpers/app_typography.dart';

class SightActionsButtons extends StatelessWidget {
  const SightActionsButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 22,
                height: 19,
                color: AppColors.waterlooInactive,
              ),
              const SizedBox(
                width: 9,
              ),
              Text(
                AppStrings.planText,
                style: AppTypography.roboto14Regular.copyWith(
                  color: AppColors.waterlooInactive,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 20,
                height: 18,
                color: AppColors.oxfordBlue,
              ),
              const SizedBox(
                width: 9,
              ),
              Text(
                AppStrings.toFavorites,
                style: AppTypography.roboto14Regular.copyWith(
                  color: AppColors.oxfordBlue,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
