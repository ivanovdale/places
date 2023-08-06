import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/data/interactor/place_interactor.dart';
import 'package:places/core/presentation/widgets/placeholders/error_placeholder.dart';
import 'package:places/features/place_details/presentation/cubit/place_details_cubit.dart';
import 'package:places/features/place_details/presentation/widgets/sliver_app_bar_place_photos/sliver_app_bar_place_photos.dart';
import 'package:places/features/place_details/presentation/widgets/sliver_place_details/sliver_place_details.dart';

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

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      builder: (_, scrollController) => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        child: Scaffold(
          bottomSheet: BlocProvider(
            create: (context) => PlaceDetailsCubit(
              context.read<PlaceInteractor>(),
            )..loadPlaceDetails(
                placeId,
              ),
            child: BlocBuilder<PlaceDetailsCubit, PlaceDetailsState>(
              builder: (context, state) {
                return switch (state) {
                  PlaceDetailsInitial() => const SizedBox.shrink(),
                  PlaceDetailsLoadInProgress() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  PlaceDetailsLoadFailure() => const Center(
                      child: ErrorPlaceHolder(),
                    ),
                  PlaceDetailsLoadSuccess() => CustomScrollView(
                      controller: scrollController,
                      slivers: [
                        SliverAppBarPlacePhotos(state.place),
                        SliverPlaceDetails(state.place),
                      ],
                    )
                };
              },
            ),
          ),
        ),
      ),
    );
  }
}
