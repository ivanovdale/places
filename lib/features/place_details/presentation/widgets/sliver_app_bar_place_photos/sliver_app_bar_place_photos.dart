import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/core/domain/model/place.dart';
import 'package:places/features/place_details/presentation/widgets/sliver_app_bar_place_photos/components/close_button.dart'
    as app_bar;
import 'package:places/features/place_details/presentation/widgets/sliver_app_bar_place_photos/components/page_indicator.dart';
import 'package:places/features/place_details/presentation/widgets/sliver_app_bar_place_photos/components/photo_gallery.dart';
import 'package:places/features/place_details/presentation/widgets/sliver_app_bar_place_photos/components/swipe_down_button.dart';
import 'package:places/features/place_details/presentation/widgets/sliver_app_bar_place_photos/cubit/photo_gallery_cubit.dart';

/// Сливер фотографий места.
///
/// Отображает картинки места и имеет кнопку "Закрыть".
/// Сворачивается при скроллинге.
class SliverAppBarPlacePhotos extends StatefulWidget {
  final Place place;

  const SliverAppBarPlacePhotos(
    this.place, {
    super.key,
  });

  @override
  State<SliverAppBarPlacePhotos> createState() =>
      _SliverAppBarPlacePhotosState();
}

class _SliverAppBarPlacePhotosState extends State<SliverAppBarPlacePhotos> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 360,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: BlocProvider(
          create: (context) => PhotoGalleryCubit(),
          child: BlocBuilder<PhotoGalleryCubit, PhotoGalleryState>(
            builder: (context, state) {
              final cubit = context.read<PhotoGalleryCubit>();

              return Stack(
                alignment: Alignment.center,
                children: [
                  PhotoGallery(
                    place: widget.place,
                    controller: _pageController,
                    onPageChanged: cubit.setActivePage,
                  ),
                  PageIndicator(
                    length: widget.place.photoUrlList?.length ?? 0,
                    controller: _pageController,
                    activePage: state.activePage,
                  ),
                  const app_bar.CloseButton(),
                  const SwipeDownButton(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
