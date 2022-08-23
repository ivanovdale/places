import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_typography.dart';

/// Виджет карточки достопримечательности.
///
/// Отображает краткую информацию о месте.
///
/// Обязательный параметр конструктора: [sight] - модель достопримечательности.
class SightCard extends StatelessWidget {
  /// Модель достопримечательности.
  final Sight sight;

  const SightCard(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
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
                ),
              ),
            ),
            Expanded(
              child: SizedBox.expand(
                child: DecoratedBox(
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
