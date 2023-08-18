import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/interactor/place_interactor.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/core/presentation/widgets/custom_circular_loading_indicator.dart';
import 'package:places/core/presentation/widgets/placeholders/error_placeholder.dart';
import 'package:places/features/place_details/presentation/cubit/place_details_cubit.dart';
import 'package:places/features/place_details/presentation/widgets/bottom_sheet_or_scaffold.dart';
import 'package:places/features/place_details/presentation/widgets/sliver_app_bar_place_photos/sliver_app_bar_place_photos.dart';
import 'package:places/features/place_details/presentation/widgets/sliver_place_details/sliver_place_details.dart';

/// Экран подробностей места.
///
/// Отображает картинку, название, тип, режим работы, описание места.
/// Предоставляет возможность построить маршрут к этому месту.
/// Также есть возможность запланировать поход в место и добавить его в список избранного.
///
/// Обязательный параметр конструктора: [place] - место.
class PlaceDetailsScreen extends StatelessWidget {
  final Place place;
  final bool isBottomSheet;

  const PlaceDetailsScreen(
    this.place, {
    super.key,
    this.isBottomSheet = true,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheetOrScaffold(
      isBottomSheet: isBottomSheet,
      bottomSheetBuilder: (_, controller) => _PlaceDetailsScreenContent(
        place: place,
        scrollController: controller,
        isBottomSheet: isBottomSheet,
      ),
      scaffoldChild: _PlaceDetailsScreenContent(
        place: place,
        isBottomSheet: isBottomSheet,
      ),
    );
  }
}

class _PlaceDetailsScreenContent extends StatelessWidget {
  final Place place;
  final ScrollController? scrollController;
  final bool isBottomSheet;

  const _PlaceDetailsScreenContent({
    required this.place,
    this.scrollController,
    required this.isBottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlaceDetailsCubit(
        context.read<PlaceInteractor>(),
        place,
      )..loadPlaceDetails(
          place.id!,
        ),
      child: BlocBuilder<PlaceDetailsCubit, PlaceDetailsState>(
        builder: (_, state) => switch (state) {
          PlaceDetailsInitial() ||
          PlaceDetailsLoadInProgress() ||
          PlaceDetailsLoadSuccess() =>
            _PlacePhotosAndDetails(
              state: state,
              scrollController: scrollController,
              isBottomSheet: isBottomSheet,
            ),
          PlaceDetailsLoadFailure() => const Center(
              child: ErrorPlaceHolder(),
            ),
        },
      ),
    );
  }
}

class _PlacePhotosAndDetails extends StatelessWidget {
  final PlaceDetailsState state;
  final ScrollController? scrollController;
  final bool isBottomSheet;

  const _PlacePhotosAndDetails({
    required this.state,
    this.scrollController,
    required this.isBottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBarPlacePhotos(
          state.place,
          showCloseButton: isBottomSheet,
        ),
        _SliverLoadingOrPlaceDetails(
          state: state,
        ),
      ],
    );
  }
}

class _SliverLoadingOrPlaceDetails extends StatelessWidget {
  final PlaceDetailsState state;

  const _SliverLoadingOrPlaceDetails({
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return state is PlaceDetailsInitial || state is PlaceDetailsLoadInProgress
        ? const SliverFillRemaining(
            child: Center(
              child: CustomCircularLoadingIndicator(),
            ),
          )
        : SliverPlaceDetails(state.place);
  }
}
