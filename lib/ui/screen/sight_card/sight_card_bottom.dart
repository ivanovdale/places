import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_typography.dart';

class SightCardBottom extends StatelessWidget {
  final Sight sight;

  const SightCardBottom({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        color: AppColors.wildSand,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 2,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                sight.name,
                style: AppTypography.roboto16Regular.copyWith(
                  color: AppColors.oxfordBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                sight.details,
                style: AppTypography.roboto14Regular.copyWith(
                  color: AppColors.waterloo,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
