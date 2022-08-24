import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_typography.dart';

/// Виджет верхняя часть карточки достопримечательности.
///
/// Содержит картинку и тип места.
///
/// Имеет параметр [sight] - модель достопримечательности.
class SightCardTop extends StatelessWidget {
  /// Модель достопримечательности.
  final Sight sight;

  const SightCardTop({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        color: AppColors.blue,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              sight.type.toString(),
              style: AppTypography.roboto14Regular
                  .copyWith(color: AppColors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 18,
              top: 19,
            ),
            child: Container(
              width: 20,
              height: 18,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
