import 'package:flutter/material.dart';
import 'package:places/core/data/interactor/place_interactor.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/presentation/widgets/placeholders/error_placeholder.dart';
import 'package:places/features/place_details/presentation/widgets/sliver_app_bar_place_photos/sliver_app_bar_place_photos.dart';
import 'package:places/features/place_details/presentation/widgets/sliver_place_details/sliver_place_details.dart';
import 'package:places/providers/place_details_provider.dart';
import 'package:provider/provider.dart';

/// Экран подробностей места.
///
/// Отображает картинку, название, тип, режим работы, описание места.
/// Предоставляет возможность построить маршрут к этому месту.
/// Также есть возможность запланировать поход в место и добавить его в список избранного.
///
/// Обязательный параметр конструктора: [placeId] - идентификатор места.
class PlaceDetailsScreen extends StatelessWidget {
  final int placeId;

  const PlaceDetailsScreen(
    this.placeId, {
    Key? key,
  }) : super(key: key);

  /// Получает детальную информацию места.
  Future<Place> _getPlaceDetails(int placeId, BuildContext context) {
    return context.read<PlaceInteractor>().getPlaceDetails(placeId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Place>(
      future: _getPlaceDetails(placeId, context),
      builder: (context, snapshot) {
        return snapshot.hasData || snapshot.hasError
            ? DraggableScrollableSheet(
                initialChildSize: 0.9,
                maxChildSize: 0.9,
                minChildSize: 0.5,
                builder: (_, scrollController) => ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Scaffold(
                    bottomSheet: snapshot.hasData
                        ? ChangeNotifierProvider(
                            create: (context) => PlaceDetailsProvider(),
                            child: CustomScrollView(
                              controller: scrollController,
                              slivers: [
                                SliverAppBarPlacePhotos(snapshot.data!),
                                SliverPlaceDetails(snapshot.data!),
                              ],
                            ),
                          )
                        : const Center(
                            child: ErrorPlaceHolder(),
                          ),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
