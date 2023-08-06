import 'package:flutter/material.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/place_details/presentation/widgets/sliver_app_bar_place_photos/components/close_button.dart'
    as app_bar;
import 'package:places/features/place_details/presentation/widgets/sliver_app_bar_place_photos/components/page_indicator.dart';
import 'package:places/features/place_details/presentation/widgets/sliver_app_bar_place_photos/components/photo_gallery.dart';
import 'package:places/features/place_details/presentation/widgets/sliver_app_bar_place_photos/components/swipe_down_button.dart';
import 'package:places/providers/place_details_provider.dart';
import 'package:provider/provider.dart';

/// Сливер фотографий места.
///
/// Отображает картинки места и имеет кнопку "Закрыть".
/// Сворачивается при скроллинге.
class SliverAppBarPlacePhotos extends StatelessWidget {
  final Place place;

  const SliverAppBarPlacePhotos(
    this.place, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 360,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Consumer<PlaceDetailsProvider>(
          builder: (context, viewModel, child) => Stack(
            alignment: Alignment.center,
            children: [
              PhotoGallery(
                place: place,
                controller: viewModel.pageController,
                onPageChanged: viewModel.setActivePage,
              ),
              PageIndicator(
                length: place.photoUrlList?.length ?? 0,
                controller: viewModel.pageController,
                activePage: viewModel.activePage,
              ),
              const app_bar.CloseButton(),
              const SwipeDownButton(),
            ],
          ),
        ),
      ),
    );
  }
}
