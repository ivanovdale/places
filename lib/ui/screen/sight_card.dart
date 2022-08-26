import 'package:flutter/cupertino.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_typography.dart';
import 'package:places/ui/screen/components/loading_indicator.dart';

/// Виджет карточки достопримечательности.
///
/// Отображает краткую информацию о месте.
///
/// Обязательный параметр конструктора: [sight] - модель достопримечательности.
class SightCard extends StatelessWidget {
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
              child: _SightCardTop(sight: sight),
            ),
            Expanded(
              child: _SightCardBottom(sight: sight),
            ),
          ],
        ),
      ),
    );
  }
}

/// Виджет верхняя часть карточки достопримечательности.
///
/// Содержит картинку и тип места.
///
/// Имеет параметр [sight] - модель достопримечательности.
class _SightCardTop extends StatelessWidget {
  final Sight sight;

  const _SightCardTop({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        image: DecorationImage(
          image: Image.network(
            sight.url,
            loadingBuilder: LoadingIndicator.imageLoadingBuilder,
          ).image,
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 16.0,
            ),
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
            // Здесь будет картинка.
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

/// Виджет нижняя часть карточки достопримечательности.
///
/// Содержит краткую информацию о месте (Название места, краткое описание).
///
/// Имеет параметр [sight] - модель достопримечательности.
class _SightCardBottom extends StatelessWidget {
  final Sight sight;

  const _SightCardBottom({Key? key, required this.sight}) : super(key: key);

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Text(
              sight.name,
              style: AppTypography.roboto16Regular.copyWith(
                color: AppColors.oxfordBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Text(
                sight.details,
                maxLines: 2,
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
